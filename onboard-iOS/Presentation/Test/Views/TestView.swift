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

    // MARK: - Properties

    var didTapAppleButton: (() -> Void)?

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
        self.addConfigure()
        self.makeConstraints()
    }

    private func addConfigure() {
        self.appleButton.addAction(UIAction(handler: { _ in
            self.didTapAppleButton?()
        }), for: .touchUpInside)
    }

    private func makeConstraints() {
        self.addSubview(self.label)
        self.addSubview(self.appleButton)

        self.label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY).offset(-Metric.labelBottomMargin)
        }

        self.appleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
            $0.top.equalTo(self.snp.centerY)
        }
    }
}
