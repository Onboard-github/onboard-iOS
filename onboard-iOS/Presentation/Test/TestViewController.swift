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
    private let alertView = PopupView()

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

    // MARK: - Bind

    func bind(reactor: TestReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }

    private func bindAction(reactor: TestReactor) {
        self.rx.rxViewDidLoad
            .map { Reactor.Action.testAPI }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.testView.didTapAppleButton = {
            reactor.action.onNext(.apple)
        }
        
        self.testView.didTapKakaoButton = {
            reactor.action.onNext(.kakao)
        }
        
        self.testView.didTapProfileButton = { [self] in
            view.addSubview(alertView)
            
            let popupState = PopupState(titleLabel: "프로필 설정",
                                        subTitleLabel: "모임에서 사용할 닉네임을 10자 이하로 입력해주세요.",
                                        textFieldPlaceholder: "닉네임을 입력해주세요.",
                                        textFieldSubTitleLabel: "한글, 영문, 숫자를 조합하여 사용 가능합니다.",
                                        countLabel: "0/10",
                                        buttonLabel: "모임 등록하기",
                                        linkButtonState: LinkButtonState(isLink: true))
            
            alertView.setState(popupState: popupState, onClickLink: { })
            alertView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            alertView.contentView.snp.makeConstraints {
                $0.height.equalTo(228)
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
}
