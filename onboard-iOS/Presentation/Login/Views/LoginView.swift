//
//  LoginView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/10/08.
//

import UIKit

import SnapKit

final class LoginView: UIView {

    // MARK: - Metric

    private enum Metric {
        static let titleTopMargin: CGFloat = 215
        static let logoTopMarign: CGFloat = 14
        static let subtitleTopMargin: CGFloat = 19
        static let loginButtonHMargin: CGFloat = 18
        static let loginButtonHeight: CGFloat = 48
        static let loginButtonVMargin: CGFloat = 8
        static let bottomMargin: CGFloat = 40
    }

    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "보드게임 랭킹 서비스"
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "보드게임을 더 즐겁게"
        return label
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_onboardLogo")
        return imageView
    }()

    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_Google"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    private let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_Apple"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    private let kakaoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_Kakao"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()

    // MARK: - Properties

    var didTapAppleButton: (() -> Void)?
    var didTapKakaoButton: (() -> Void)?
    var didTapGoogleButton: (() -> Void)?

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind() {
        // bind
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white
        self.addConfigure()
        self.makeConstraints()
    }

    private func addConfigure() {
        self.appleButton.addAction(UIAction(
            handler: { _ in
                self.didTapAppleButton?()
            }), for: .touchUpInside
        )

        self.kakaoButton.addAction(UIAction(
            handler: { _ in
                self.didTapKakaoButton?()
            }), for: .touchUpInside
        )
        
        self.googleButton.addAction(UIAction(
            handler: { _ in
                self.didTapGoogleButton?()
            }), for: .touchUpInside
        )
    }

    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.logoImageView)
        self.addSubview(self.subtitleLabel)

        self.addSubview(self.googleButton)
        self.addSubview(self.appleButton)
        self.addSubview(self.kakaoButton)

        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Metric.titleTopMargin)
        }

        self.logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.logoTopMarign)
        }

        self.subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(Metric.subtitleTopMargin)
        }

        self.appleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.loginButtonHMargin)
            $0.height.equalTo(Metric.loginButtonHeight)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-Metric.bottomMargin)
        }

        self.kakaoButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.loginButtonHMargin)
            $0.height.equalTo(Metric.loginButtonHeight)
            $0.bottom.equalTo(self.googleButton.snp.top).offset(-Metric.loginButtonVMargin)
        }

        self.googleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.loginButtonHMargin)
            $0.height.equalTo(Metric.loginButtonHeight)
            $0.bottom.equalTo(self.appleButton.snp.top).offset(-Metric.loginButtonVMargin)
        }
    }
}
