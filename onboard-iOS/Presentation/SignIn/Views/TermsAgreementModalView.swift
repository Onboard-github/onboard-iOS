//
//  TermsAgreementModalView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/28.
//

import UIKit

final class TermsAgreementModalView: UIView {

    // MARK: - Metric

    private enum Metric {
        static let registerButtonRadius: CGFloat = 8

        static let titleTop: CGFloat = 40
        static let titleHMargin: CGFloat = 24

        static let subTitleTop: CGFloat = 4
        static let subTitleHMargin: CGFloat = 24

        static let tableViewTop: CGFloat = 40
        static let tableViewHMargin: CGFloat = 20
        static let tableViewBottom: CGFloat = 20

        static let separatorBottom: CGFloat = 20
        static let separatorHeight: CGFloat = 1
        static let separatorLeading: CGFloat = 37
        static let separatorTrailing: CGFloat = 27

        static let allAgreementButtonBottom: CGFloat = 40
        static let allAgreementButtonHeight: CGFloat = 22
        static let allAgreementButtonTrailing: CGFloat = 27

        static let registerButtonHeight: CGFloat = 48
        static let registerButtonHMargin: CGFloat = 20
    }

    // MARK: - UI

    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()

    private let tableView = UITableView()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private let allAgreementButton: UIButton = {
        let button = UIButton()
        button.setTitle("약관 전체 동의  ", for: .normal)
        button.setImage(UIImage(named: "img_select_off"), for: .normal)
        button.setImage(UIImage(named: "img_select_on"), for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = Metric.registerButtonRadius
        button.clipsToBounds = true
        return button
    }()

    // MARK: - Properties

    private var termsList: [String] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(termsList: [String]) {
        self.termsList = termsList
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white
        self.tableView.registCell(type: TermsAgreementCell.self)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none

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
        self.addSubview(self.tableView)
        self.addSubview(self.separatorView)
        self.addSubview(self.allAgreementButton)
        self.addSubview(self.registerButton)

        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Metric.titleTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.titleHMargin)
        }

        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.subTitleTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.subTitleHMargin)
        }

        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel).offset(Metric.tableViewTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.tableViewHMargin)
            $0.bottom.equalTo(self.separatorView.snp.top).offset(-Metric.tableViewBottom)
        }

        self.separatorView.snp.makeConstraints {
            $0.bottom.equalTo(self.allAgreementButton.snp.top).offset(-Metric.separatorBottom)
            $0.height.equalTo(Metric.separatorHeight)
            $0.leading.equalToSuperview().inset(Metric.separatorLeading)
            $0.trailing.equalToSuperview().inset(Metric.separatorTrailing)
        }

        self.allAgreementButton.snp.makeConstraints {
            $0.bottom.equalTo(self.registerButton.snp.top).offset(-Metric.allAgreementButtonBottom)
            $0.height.equalTo(Metric.allAgreementButtonHeight)
            $0.trailing.equalToSuperview().inset(Metric.allAgreementButtonTrailing)
        }

        self.registerButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(Metric.registerButtonHeight)
            $0.leading.trailing.equalToSuperview().inset(Metric.registerButtonHMargin)
        }
    }
}

extension TermsAgreementModalView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.termsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: TermsAgreementCell.self, for: indexPath)
        cell.bind(self.termsList[indexPath.row])

        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsAgreementModalViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {

            let view = TermsAgreementModalView()
            view.bind(termsList: ["서비스 이용약관", "개인정보 처리방침"])
            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
