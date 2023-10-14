//
//  GroupSearchView.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import UIKit
import SnapKit

final class GroupSearchView: UIView {
    // MARK: - UI
    private let button = UIButton()
    
    // MARK: - Properties
    var didTapButton: (() -> Void)?

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
        self.button.setTitle("\(text)", for: .normal)
    }

    // MARK: - Configure
    private func configure() {
        self.backgroundColor = .white
        self.addConfigure()
        self.makeConstraints()
    }

    private func addConfigure() {
        button.backgroundColor = .lightGray
        self.button.addAction(UIAction(handler: { _ in
            self.didTapButton?()
        }), for: .touchUpInside)
    }

    private func makeConstraints() {
        self.addSubview(self.button)

        self.button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY)
        }
    }
}
