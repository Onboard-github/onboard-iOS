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
    
    // MARK: - State
    
    struct State {
        let terms: [TermsAgreementItemView.State]
        let isAllAgreement: Bool
    }

    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Typography.title1
        label.textColor = Colors.Gray_15
        label.text = "서비스 이용 동의"
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Typography.body3_R
        label.textColor = Colors.Gray_8
        label.text = "온보드를 사용하기 위해 약관에 동의해주세요"
        return label
    }()

    private let tableView = UITableView()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_2
        return view
    }()
 
    private let allAgreementButton: UIButton = {
        let button = UIButton()
        button.setTitle("약관 전체 동의  ", for: .normal)
        button.titleLabel?.font = Font.Typography.title3
        button.setImage(UIImage(named: "img_select_off"), for: .normal)
        button.setImage(UIImage(named: "img_select_on"), for: .selected)
        button.setTitleColor(Colors.Gray_15, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    private let registerButton = BaseButton(status: .disabled, style: .rounded)
    
    // MARK: - Properties

    private var termsList: [TermsAgreementItemView.State] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var selectDetail: ((IndexPath) -> Void)?
    var selectCheck: ((IndexPath) -> Void)?
    var selectAllCheck: (() -> Void)?
    var selectRegister: (() -> Void)?

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Bind

    func bind(state: State) {
        self.termsList = state.terms
        self.allAgreementButton.isSelected = state.isAllAgreement
        
        self.registerButton.setButton(
            status: state.isAllAgreement
            ? .default
            : .disabled,
            style: .rounded
        )
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white
        self.tableView.registCell(type: TermsAgreementCell.self)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none

        self.registerButton.setTitle("가입하기", for: .normal)
        self.setRegisterButtonAction()

        self.makeConstraints()
        self.setAllAgreementButtonAction()
    }
    
    private func setRegisterButtonAction() {
        let action = UIAction(handler: { _ in
            self.selectRegister?()
        })
        self.registerButton.addAction(action, for: .touchUpInside)
    }
    
    private func setAllAgreementButtonAction() {
        let action = UIAction(handler: { _ in
            self.selectAllCheck?()
        })
        self.allAgreementButton.addAction(action, for: .touchUpInside)
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
        
        cell.selectDetail = { self.selectDetail?(indexPath) }
        cell.selectCheck = { self.selectCheck?(indexPath) }
        
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsAgreementModalViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            
            let view = TermsAgreementModalView()
            view.bind(state: .init(
                terms: [
                    .init(title: "개인정보 처리방침", isRequired: true, isChecked: false),
                    .init(title: "서비스 이용약관", isRequired: true, isChecked: false)
                ],
                isAllAgreement: false
            ))
            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
