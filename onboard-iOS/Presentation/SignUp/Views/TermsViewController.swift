//
//  TermsViewController.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/26/23.
//

import UIKit

import ReactorKit

final class TermsViewController: UIViewController, View {
    
    internal var disposeBag = DisposeBag()
    
    typealias Reactor = TermsReactor
    
    private let termsView = TermsView()
    
    override func loadView() {
        self.view = termsView
    }
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: Reactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: Reactor) {
        self.rx.rxViewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func bindState(reactor: Reactor) {
        reactor.state
            .map { $0.url }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                self.termsView.bind(url: result)
            })
            .disposed(by: self.disposeBag)
    }
}
