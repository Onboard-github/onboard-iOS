//
//  TermsAgreementCell.swift
//  onboard-iOS
//
//  Created by Daye on 2023/10/09.
//

import UIKit

final class TermsAgreementCell: BaseTableViewCell<String> {

    // MARK: - UIs

    private let itemView = TermsAgreementItemView()

    override func bind(_ model: String?) {
        self.itemView.bind(title: model ?? "")
    }

    // MARK: - Layout

    override func setupConstraints() {
        self.contentView.addSubview(self.itemView)

        self.itemView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(7)
            $0.top.bottom.equalToSuperview()
        }
    }
}
