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
    
    override func loadView() {
        self.view = groupSearchView
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
    }

    private func bindState(reactor: GroupSearchReactor) {
        reactor.state
            .map { $0.groupList }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.groupSearchView.bind(groupList: result)
            })
            .disposed(by: self.disposeBag)
    }
}

