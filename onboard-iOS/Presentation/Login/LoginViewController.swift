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

    private let testView = TestView()

    // MARK: - Life Cycles

    override func loadView() {
        self.view = testView
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
        self.testView.googleLoginButtonAction = {
            reactor.action.onNext(.google)
        }

        self.testView.didTapAppleButton = {
            reactor.action.onNext(.apple)
        }

        self.testView.didTapKakaoButton = {
            reactor.action.onNext(.kakao)
        }
    }

    private func bindState(reactor: LoginReactor) {
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
