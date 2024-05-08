//
//  MyProfileViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/30/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class MyProfileViewController: UIViewController, View {
    
    typealias Reactor = UserReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    private let myProfileView = MyProfileView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = myProfileView
    }
    
    // MARK: - Initialize
    
    init(reactor: UserReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Bind
    
    func bind(reactor: UserReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: UserReactor) {
        let groupId = GameDataSingleton.shared.getGroupId() ?? 0
        self.reactor?.action.onNext(.myGroupInfoData(groupId: groupId))
    }
    
    func bindState(reactor: UserReactor) {
        reactor.state
            .compactMap { $0.groupInfoData }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.myProfileView.bind(group: data?.name ?? "error",
                                         nickname: OnBoardSingleton.shared.myGroupNicknameText.value)
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.nicknameResult?.reason }
            .map { reason -> TextFieldState in
                switch reason {
                case "DUPLICATED_NICKNAME":
                    return .overLap
                case "INVALID_NICKNAME":
                    return .invalid
                default:
                    return .normal
                }
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                DispatchQueue.main.async {
                    self?.updateTextFieldState(for: state)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure
    
    private func configure() {
        
        self.setNavigationBar()
        
        self.setTextField()
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(Colors.Black, renderingMode: .alwaysOriginal)
        
        if let navigationBar = navigationController?.navigationBar {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: Font.Typography.title2 as Any,
                NSAttributedString.Key.foregroundColor: Colors.Gray_14
            ]
            navigationBar.titleTextAttributes = titleTextAttributes
        }
        
        navigationController?.navigationBar.barTintColor = Colors.Gray_2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image, style: .done,
            target: self, action: #selector(showPrevious))
        navigationItem.title = TextLabels.profile_title
    }
    
    @objc
    private func showPrevious() {
        self.dismiss(animated: true)
    }
}

// MARK: - TextField

extension MyProfileViewController {
    
    private func setTextField() {
        self.myProfileView.nicknameTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                let groupId = GameDataSingleton.shared.getGroupId() ?? 0
                let nickname = OnBoardSingleton.shared.newGroupUserNameText.value
                self?.reactor?.action.onNext(.validateNickname(groupId: groupId,
                                                               nickname: nickname))
            })
            .disposed(by: disposeBag)
        
        self.myProfileView.nicknameTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .map(inputText(_:))
            .subscribe(onNext: { [weak self] result in
                self?.updateTextFieldState(for: result)
            })
            .disposed(by: disposeBag)
    }
    
    private func inputText(_ text: String) -> TextFieldState {
        if text.count >= 10 {
            let index = text.index(text.startIndex, offsetBy: 10)
            self.myProfileView.nicknameTextField.text = String(text[..<index])
            return .over
        }
        
        return .normal
    }
    
    private func updateTextFieldState(for state: TextFieldState) {
        switch state {
        case .over:
            self.myProfileView.textFieldSubTitleLabel.text = TextLabels.userInfo_textField_subTitle
            self.myProfileView.textFieldSubTitleLabel.textColor = Colors.Gray_8
            self.myProfileView.countLabel.textColor = Colors.Red
            self.myProfileView.confirmButton.status = .disabled
            
        case .overLap:
            self.myProfileView.textFieldSubTitleLabel.text = TextLabels.bottom_textField_already
            self.myProfileView.textFieldSubTitleLabel.textColor = Colors.Red
            self.myProfileView.countLabel.textColor = Colors.Gray_8
            self.myProfileView.confirmButton.status = .disabled
            
        case .invalid:
            self.myProfileView.textFieldSubTitleLabel.text = TextLabels.userInfo_textField_subTitle
            self.myProfileView.textFieldSubTitleLabel.textColor = Colors.Gray_8
            self.myProfileView.countLabel.textColor = Colors.Gray_8
            self.myProfileView.confirmButton.status = .disabled
            
        case .normal:
            self.myProfileView.textFieldSubTitleLabel.text = TextLabels.userInfo_textField_subTitle
            self.myProfileView.textFieldSubTitleLabel.textColor = Colors.Gray_8
            self.myProfileView.countLabel.textColor = Colors.Gray_8
            self.myProfileView.confirmButton.status = .default
            
            let groupId = GameDataSingleton.shared.getGroupId() ?? 0
            let memberId = GameDataSingleton.shared.memberId.value
            let nickname = OnBoardSingleton.shared.newGroupUserNameText.value
            self.myProfileView.didTapConfirmButton = { [weak self] in
                self?.reactor?.action.onNext(.groupMemberPatch(
                    req: MemberEntity.GroupMemberPatchReq(
                        nickname: nickname
                    ),
                    groupId: groupId,
                    memberId: memberId)
                )
            }
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension MyProfileViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}
