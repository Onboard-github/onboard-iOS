//
//  UpdateUserInfoViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/21/24.
//

import UIKit

import ReactorKit

final class UpdateUserInfoViewController: UIViewController, View {
    
    typealias Reactor = UserReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    private let updateUserInfoView = UpdateUserInfoView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = updateUserInfoView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = TextLabels.userInfo_title
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Initialize
    
    init(reactor: UserReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind(reactor: UserReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: UserReactor) {
        self.updateUserInfoView.didTapButtonAction = {
            let req = UpdateMyNicknameEntity.Req(nickname: OnBoardSingleton.shared.newUserNameText.value)
            reactor.action.onNext(.updateMe(req: req))
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
            homeTabController.modalPresentationStyle = .fullScreen
            navigationController?.present(homeTabController, animated: true)
        }
    }
    
    func bindState(reactor: UserReactor) {
        
    }
}
