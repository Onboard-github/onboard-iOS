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

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Bind

    func bind(reactor: TestReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }

    private func bindAction(reactor: TestReactor) {
        
    }

    private func bindState(reactor: TestReactor) {

    }

}
