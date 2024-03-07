//
//  GroupSettingViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit
import ReactorKit

final class GroupSettingViewController: UIViewController, View {
    
    typealias Reactor = GroupReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 25
    }
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 58
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        view.isScrollEnabled = false
        
        view.delegate = self
        view.dataSource = self
        view.register(GroupSettingTableViewCell.self,
                      forCellReuseIdentifier: "GroupSettingTableViewCell")
        return view
    }()
    
    // MARK: - Initialize
    
    init(reactor: GroupReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind(reactor: GroupReactor) {
        self.bindAction(reactor: reactor)
    }
    
    func bindAction(reactor: GroupReactor) {
        let groupId = GameDataSingleton.shared.getGroupId() ?? 0
        let gameId = GameDataSingleton.shared.gameData?.id ?? 0
        self.reactor?.action.onNext(.fetchResult(groupId: groupId))
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.view.backgroundColor = Colors.White
        
        self.makeConstraints()
        self.setNavigationBar()
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        if let navigationBar = navigationController?.navigationBar {
            let textAttribute: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: Font.Typography.title2 as Any,
                NSAttributedString.Key.foregroundColor: Colors.Gray_14
            ]
            navigationBar.titleTextAttributes = textAttribute
        }
        
        navigationController?.navigationBar.barTintColor = Colors.White
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image, style: .done,
            target: self, action: #selector(showPrevious))
        navigationItem.title = TextLabels.setting_title
    }
    
    @objc
    private func showPrevious() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension GroupSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return SettingOptions.allCases.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupSettingTableViewCell",
                                                 for: indexPath) as! GroupSettingTableViewCell
        if let option = SettingOptions(rawValue: indexPath.row) {
            cell.setOption(option)
        }
        // cell.separatorView.isHidden = indexPath.row != SettingOptions.allCases.count - 2
        cell.separatorView.isHidden = true
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
//        switch indexPath.row {
//        case 0:
//            // TODO: - 모임 정보 수정
//            break
//        case 1:
//            let vc = AccessCodeViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        case 2:
//            let vc = MemberManageViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        case 3:
//            let vc = OwnerManageViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        case 4:
//            // TODO: - 모임 삭제
//            break
//        default:
//            break
//        }
        
        switch indexPath.row {
        case 0:
            let useCase = GroupUseCaseImpl(repository: GroupRepositoryImpl())
            let playerUseCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
            let memberUseCase = MemberUseCaseImpl(repository: MemberRepositoryImpl())
            let reactor = GroupReactor(useCase: useCase, playerUseCase: playerUseCase, memberUseCase: memberUseCase)
            let vc = OwnerManageViewController(reactor: reactor)
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let alert = ConfirmPopupViewController()
            alert.modalPresentationStyle = .overFullScreen
            
            let groupName = self.reactor?.currentState.groupInfoData?.name ?? ""
            let message = "\(TextLabels.groupInfo_groupDelete_message)\(groupName) \(TextLabels.groupInfo_groupDelete_delete_message)"
            let attributedString = NSMutableAttributedString(string: message)
            let range = (message as NSString).range(of: groupName)
            attributedString.addAttribute(.font, value: Font.Typography.title3 as Any, range: range)
            
            let state = AlertState(contentLabel: attributedString,
                                   leftButtonLabel: TextLabels.groupInfo_button_cancel,
                                   rightButtonLabel: TextLabels.groupInfo_button_delete)
            
            alert.setState(alertState: state)
            alert.setContentViewHeight(height: 234)
            
            self.present(alert, animated: false)
        default:
            break
        }
    }
}
