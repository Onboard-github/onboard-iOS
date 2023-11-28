//
//  NicknameViewController.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import UIKit

import ReactorKit

final class NicknameViewController: UIViewController, View {
    
    internal var disposeBag = DisposeBag()
    
    typealias Reactor = NicknameReactor
    
    private let nicknameView = NicknameView()
    
    override func loadView() {
        self.view = nicknameView
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
    }
    
    private func bindState(reactor: Reactor) {

    }
}
