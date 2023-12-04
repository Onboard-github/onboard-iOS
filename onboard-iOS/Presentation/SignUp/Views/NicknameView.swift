//
//  NicknameView.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import UIKit

import SnapKit

final class NicknameView: UIView {
    
    // MARK: - Metric

    private enum Metric {
        static let topMargin: CGFloat = 16
        static let widthInset: CGFloat = 28
    }

    // MARK: - UI

    private let headingLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Typography.title1
        label.textColor = Colors.Gray_14
        label.numberOfLines = 2
        label.text = "가입을 축하드려요!\n플레이어님의 이름을 알려주세요"
        return label
    }()
    private let stackView = UIStackView()
    private let textField: TextField = {
        let textField = TextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.backgroundColor = .white
        textField.font = Font.Typography.body3_R
        return textField
    }()
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Typography.body5_R
        label.textColor = Colors.Gray_8
        label.text = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
        return label
    }()
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .rounded)
        button.setTitle("확인", for: .normal)
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
        
        self.stackView.axis = .vertical
        self.stackView.spacing = 4
        self.makeConstraints()
    }

    private func makeConstraints() {
        self.addSubview(headingLabel)
        self.addSubview(stackView)
        self.addSubview(confirmButton)
        
        self.stackView.addArrangedSubview(textField)
        self.stackView.addArrangedSubview(guideLabel)
        
        self.stackView.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.centerY)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.textField.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalTo(48)
        }
        self.guideLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
        }
        
        self.headingLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.stackView.snp.top).offset(-64)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct NicknameViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {

            let view = NicknameView()

            return view

        }.previewLayout(.sizeThatFits)
    }
}
#endif
