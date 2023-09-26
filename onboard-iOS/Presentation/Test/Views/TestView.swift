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
    private let googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var googleLoginButtonAction: (() -> Void)?

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
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
        self.makeConstraints()
        self.googleLoginButton.addAction(UIAction(handler: { _ in
            self.googleLoginButtonAction?()
        }), for: .touchUpInside)
    }

    private func makeConstraints() {
        self.addSubview(self.label)
        self.addSubview(self.googleLoginButton)

        self.label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY).offset(-Metric.labelBottomMargin)
        }
        
        self.googleLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
