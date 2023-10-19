//
//  SingUpView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit

import SnapKit

final class TestView: UIView {

    // MARK: - Metric

    private enum Metric {
        static let labelBottomMargin: CGFloat = 100
    }

    // MARK: - UI

    private let label = UILabel()
    private let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_apple_login"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    private let kakaoButton: UIButton = {
        let button = UIButton() // KOLoginButton()
        button.setTitle("kako login", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 설정", for: .normal)
        button.setTitleColor(Colors.Gray_15, for: .normal)
        button.titleLabel?.font = Font.Typography.body5_R
        return button
    }()
    
    private let memberButton: UIButton = {
        let button = UIButton()
        button.setTitle("임시 멤버 추가", for: .normal)
        button.setTitleColor(Colors.Gray_15, for: .normal)
        button.titleLabel?.font = Font.Typography.body5_R
        return button
    }()
    
    private let codeButton: UIButton = {
        let button = UIButton()
        button.setTitle("참여 코드 입력", for: .normal)
        button.setTitleColor(Colors.Gray_15, for: .normal)
        button.titleLabel?.font = Font.Typography.body5_R
        return button
    }()

    // MARK: - Properties

    var didTapAppleButton: (() -> Void)?
    var didTapKakaoButton: (() -> Void)?
    var didTapProfileButton: (() -> Void)?
    var didTapMemberButton: (() -> Void)?
    private let joinPopupView = JoinPopupView()

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        
        self.codeButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.addSubview(self.joinPopupView)
            self.joinPopupView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(text: String) {
        self.label.text = "Hi!! \(text)"
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white
        self.addConfigure()
        self.makeConstraints()
    }

    private func addConfigure() {
        self.appleButton.addAction(UIAction(handler: { _ in
            self.didTapAppleButton?()
        }), for: .touchUpInside)
        
        self.kakaoButton.addAction(UIAction(handler: { _ in
            self.didTapKakaoButton?()
        }), for: .touchUpInside)
        
        self.profileButton.addAction(UIAction(handler: { _ in
            self.didTapProfileButton?()
        }), for: .touchUpInside)
        
        self.memberButton.addAction(UIAction(handler: { _ in
            self.didTapMemberButton?()
        }), for: .touchUpInside)
    }

    private func makeConstraints() {
        self.addSubview(self.label)
        self.addSubview(self.appleButton)
        self.addSubview(self.kakaoButton)
        self.addSubview(self.profileButton)
        self.addSubview(self.memberButton)
        self.addSubview(self.codeButton)

        self.label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY).offset(-Metric.labelBottomMargin)
        }

        self.appleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
            $0.top.equalTo(self.snp.centerY)
        }
        
        self.kakaoButton.snp.makeConstraints {
            $0.leading.trailing.height.equalTo(appleButton)
            $0.top.equalTo(appleButton.snp.bottom).inset(-10)
        }
        
        self.profileButton.snp.makeConstraints {
            $0.leading.trailing.height.equalTo(appleButton)
            $0.top.equalTo(kakaoButton.snp.bottom).inset(-10)
        }
        
        self.memberButton.snp.makeConstraints {
            $0.leading.trailing.height.equalTo(appleButton)
            $0.top.equalTo(profileButton.snp.bottom).inset(-10)
        }
        
        self.codeButton.snp.makeConstraints {
            $0.leading.trailing.height.equalTo(appleButton)
            $0.top.equalTo(memberButton.snp.bottom).inset(-10)
        }
    }
}
