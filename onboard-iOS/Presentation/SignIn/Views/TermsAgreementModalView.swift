//
//  TermsAgreementModalView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/28.
//

import UIKit

final class TermsAgreementModalView: UIView {

    // MARK: - UI

    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()

    private let tableView = UITableView()

    private let separatorView = UIView()
    private let allAgreementButton = UIButton()

    private let registerButton = UIButton()

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

    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white

        self.titleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        self.titleLabel.setAttributed(
            lineHeight: 28,
            letterSpacing: -0.4,
            text: "서비스 이용 동의"
        )

        self.subTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        self.subTitleLabel.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        self.subTitleLabel.setAttributed(
            lineHeight: 20,
            letterSpacing: -0.4,
            text: "온보드를 사용하기 위해 약관에 동의해주세요"
        )

        self.makeConstraints()
    }

    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)

        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsAgreementModalViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {

            let view = TermsAgreementModalView()

            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
