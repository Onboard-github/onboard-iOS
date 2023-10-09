//
//  TermsAgreementItemView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/10/09.
//

import UIKit

final class TermsAgreementItemView: UIView {

    // MARK: - UIs

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "(필수) 서비스 이용약관"
        return label
    }()

    private let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("상세보기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()

    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "img_select_on"), for: .selected)
        button.setImage(UIImage(named: "img_select_off"), for: .normal)
        return button
    }()

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white
        self.makeConstraints()
    }

    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.detailButton)
        self.addSubview(self.checkButton)

        self.titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-80)
        }

        self.detailButton.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview()
        }

        self.checkButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(18)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsAgreementItemViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = TermsAgreementItemView()
            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
