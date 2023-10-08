//
//  LoginViewController.swift
//  onboard-iOS
//
//  Created by Daye on 2023/10/08.
//

import UIKit

import ReactorKit

final class LoginViewController: UIViewController, View {

    typealias Reactor = LoginReactor

    // MARK: - Properties

    var disposeBag = DisposeBag()

    private let loginView = LoginView()

    // MARK: - Life Cycles

    override func loadView() {
        self.view = loginView
    }

    init(reactor: LoginReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(reactor: LoginReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }

    private func bindAction(reactor: LoginReactor) {
        self.loginView.didTapGoogleButton = {
            reactor.action.onNext(.google)
        }

        self.loginView.didTapAppleButton = {
            reactor.action.onNext(.apple)
        }

        self.loginView.didTapKakaoButton = {
            reactor.action.onNext(.kakao)
        }
    }

    private func bindState(reactor: LoginReactor) {
  
    }
}
