//
//  GroupSearchView.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import UIKit
import SnapKit

final class GroupSearchView: UIView {
    // MARK: - Metric
    private enum Metric {
        static let topMargin = 20
        static let sideMargin: CGFloat = 18
    }
    
    // MARK: - UI
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "활동하고 계신\n보드게임 모임을 찾아주세요."
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return titleLabel
    }()
    
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
        self.addActionConfigure()
        self.makeConstraints()
    }

    private func addActionConfigure() {
        self.backgroundColor = .systemBackground
        button.backgroundColor = .lightGray
        self.button.addAction(UIAction(handler: { _ in
            self.didTapButton?()
        }), for: .touchUpInside)
    }

    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(Metric.topMargin)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Metric.sideMargin)
        }
        self.addSubview(self.button)

        self.button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY)
        }
    }
}
