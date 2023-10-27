//
//  SignUpViewController.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit

import ReactorKit

final class TestViewController: UIViewController, View {

    typealias Reactor = TestReactor

    // MARK: - Properties

    var disposeBag = DisposeBag()

    private let testView = TestView()
    private let popupView = PopupView()
    private let bottomSheetView = BottomSheetView()
    
    // MARK: - Life Cycles

    override func loadView() {
        self.view = testView
    }

    init(reactor: TestReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePopup() {
        view.addSubview(popupView)
        popupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Bind

    func bind(reactor: TestReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }

    private func bindAction(reactor: TestReactor) {
        self.rx.rxViewDidLoad
            .map { Reactor.Action.testAPI}
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.testView.googleLoginButtonAction = {
            reactor.action.onNext(.google)
        }

        self.testView.didTapAppleButton = {
            reactor.action.onNext(.apple)
        }
        
        self.testView.didTapKakaoButton = {
            reactor.action.onNext(.kakao)
        }
        
        self.testView.didTapProfileButton = { [self] in
            configurePopup()
            
            let popupState = PopupState(titleLabel: "프로필 설정",
                                        subTitleLabel: "모임에서 사용할 닉네임을 10자 이하로 입력해주세요.",
                                        textFieldPlaceholder: "닉네임을 입력해주세요.",
                                        textFieldSubTitleLabel: "한글, 영문, 숫자를 조합하여 사용 가능합니다.",
                                        countLabel: "0/10",
                                        buttonLabel: "모임 등록하기",
                                        linkButtonState: LinkButtonState(isLink: true))
            
            popupView.setState(popupState: popupState, onClickLink: { })
            popupView.contentView.snp.makeConstraints {
                $0.height.equalTo(228)
            }
        }
        
        self.testView.didTapMemberButton = { [self] in
            configurePopup()
            
            let popupState = PopupState(titleLabel: "임시 멤버 추가",
                                        subTitleLabel: "임시 멤버란 이런이런이유로 이런이런 사람들을 이렇게 먼저 \n들어와있게 해주는거고 나중에 가입하면 변환도 가능",
                                        textFieldPlaceholder: "닉네임을 입력해주세요.",
                                        textFieldSubTitleLabel: "한글, 영문, 숫자를 조합하여 사용 가능합니다.",
                                        countLabel: "0/10",
                                        buttonLabel: "모임 등록하기",
                                        linkButtonState: LinkButtonState(isLink: false),
                                        textFieldLabelState: TextFieldLabelState(isHidden: true))
            
            popupView.setState(popupState: popupState, onClickLink: { })
            popupView.contentView.snp.makeConstraints {
                $0.height.equalTo(272)
            }
        }
        
        self.testView.didTapbottomSheetMemberButton = { [self] in
            view.addSubview(bottomSheetView)
            bottomSheetView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            let popupState = PopupState(titleLabel: "임시 멤버 추가",
                                        subTitleLabel: "아직 온보드에 가입하지 않은 멤버를 임시로 추가해서 기록을 남기세요. Tip : 기억하기 쉬운 닉네임을 설정한 뒤 멤버에게도 알려주세요. 임시 멤버가 서비스에 가입할 때 기록을 연동할 수 있어요!",
                                        textFieldPlaceholder: "닉네임을 입력해주세요.",
                                        textFieldSubTitleLabel: "이미 추가한 임시 멤버가 아닌지 잘 확인해주세요!",
                                        countLabel: "0/10",
                                        buttonLabel: "모임 등록하기",
                                        linkButtonState: LinkButtonState(isLink: false),
                                        textFieldLabelState: TextFieldLabelState(isHidden: true))
            
            bottomSheetView.setState(popupState: popupState, onClickLink: { })
            bottomSheetView.contentView.snp.makeConstraints {
                $0.height.equalTo(272)
            }
        }
    }

    private func bindState(reactor: TestReactor) {
        reactor.state
            .map { $0.result }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.testView.bind(text: result)
            })
            .disposed(by: self.disposeBag)
    }
    
    @objc private func buttonAction() {
        GoogleLoginManager.shared.signIn(withPresenting: self)
    }
}
