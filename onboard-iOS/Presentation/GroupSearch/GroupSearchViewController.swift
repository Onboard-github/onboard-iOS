//
//  GroupSearchViewController.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import UIKit
import ReactorKit


final class GroupSearchViewController: UIViewController, View {
    
    typealias Reactor = GroupSearchReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    private let groupSearchView = GroupSearchView()
    
    // MARK: - Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        self.view = groupSearchView
        groupSearchView.delegate = self
    }
    
    init(reactor: GroupSearchReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind(reactor: GroupSearchReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: GroupSearchReactor) {
        self.rx.rxViewDidLoad
            .map { Reactor.Action.groupListAllFetch }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.groupSearchView.searchBarValueChanged = { text in
            reactor.action.onNext(.searchBarTextChanged(keyword: text))
        }
        
        self.groupSearchView.didTapAddGroupButton = { [weak self] in
            let useCase = GroupCreateUseCaseImpl(repository: GroupCreateRepositoryImpl())
            let reactor = GroupCreateReactor(useCase: useCase)
            let groupCreateViewController = GroupCreateViewController(reactor: reactor)
            
            let navigationController = UINavigationController(rootViewController: groupCreateViewController)
            navigationController.modalPresentationStyle = .fullScreen

            self?.navigationController?.present(navigationController, animated: true)
        }
    }

    private func bindState(reactor: GroupSearchReactor) {
        reactor.state
            .map { $0.groupList }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.groupSearchView.bind(groupList: result.map({$0.toPresentation()}))
            })
            .disposed(by: self.disposeBag)
    }
}

extension GroupSearchViewController: GroupSearchDelegate {
    func select(group: GroupSearchView.Group?) {
        let joinVC = GroupJoinVC()
        navigationController?.pushViewController(joinVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            joinVC.group = group
        })
    }
}

extension GroupEntity.Res.Group {
    func toPresentation() -> GroupSearchView.Group {
        return GroupSearchView.Group(id: self.id, name: self.name, description: self.description, organization: self.organization, profileImageUrl: self.profileImageUrl)
    }
}
