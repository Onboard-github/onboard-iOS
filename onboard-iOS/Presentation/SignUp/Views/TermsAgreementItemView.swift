//
//  TermsAgreementItemView.swift
//  onboard-iOS
//
//  Created by Daye on 2023/10/09.
//

import UIKit

final class TermsAgreementItemView: UIView {

    // MARK: - State

    struct State {
        let title: String
        let isRequired: Bool
        let isChecked: Bool
    }

    // MARK: - Metric

    private enum Metric {
        static let titleTrailing: CGFloat = 80
        static let detailTop: CGFloat = 6
        static let buttonSize: CGFloat = 18
        static let detailBottom: CGFloat = 20
    }

    // MARK: - UIs

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Typography.body3_M
        label.textColor = Colors.Gray_13
        return label
    }()

    private let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("상세보기", for: .normal)
        button.setTitleColor(Colors.Gray_9, for: .normal)
        button.titleLabel?.font = Font.Typography.body4_R
        return button
    }()

    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "img_select_on"), for: .selected)
        button.setImage(UIImage(named: "img_select_off"), for: .normal)
        return button
    }()

    // MARK: - Properties
    
    var selectDetail: (() -> Void)?
    var selectCheck: (() -> Void)?
    
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
        let prefix = state.isRequired ? "(필수)" : "(선택)"
        self.titleLabel.text = "\(prefix) \(state.title)"
        self.checkButton.isSelected = state.isChecked
    }

    // MARK: - Configure

    private func configure() {
        self.backgroundColor = .white
        self.makeConstraints()
        
        self.setDetailButtonAction()
        self.setCheckButtonAction()
    }

    private func setDetailButtonAction() {
        let action = UIAction(handler: { _ in
            self.selectDetail?()
        })
        self.detailButton.addAction(action, for: .touchUpInside)
    }
    
    private func setCheckButtonAction() {
        let action = UIAction(handler: { _ in
            self.selectCheck?()
        })
        self.checkButton.addAction(action, for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.detailButton)
        self.addSubview(self.checkButton)

        self.titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-Metric.titleTrailing)
        }

        self.detailButton.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.detailTop)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Metric.detailBottom)
        }

        self.checkButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(Metric.buttonSize)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TermsAgreementItemViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = TermsAgreementItemView()
            
            view.bind(state: .init(
                title: "개인정보 처리방침",
                isRequired: true,
                isChecked: false
            ))
            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
