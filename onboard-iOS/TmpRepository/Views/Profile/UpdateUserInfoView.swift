//
//  UpdateUserInfoView.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/20/24.
//

import UIKit

final class UpdateUserInfoView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 35
        static let basePadding: CGFloat = 20
        static let nicknameTopSpacing: CGFloat = 10
        static let itemSpacing: CGFloat = 30
        static let requiredLeftSpacing: CGFloat = 2
        static let textFieldTopSpacing: CGFloat = 5
        static let textFieldHeight: CGFloat = 48
        static let countRightMargin: CGFloat = 30
        static let buttonBottomMargin: CGFloat = 10
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    private let textInputTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용 중인 닉네임"
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let myNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = LoginSessionManager.getNickname()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title3
        return label
    }()
    
    private let newTextInputTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "새 이름"
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let requiredImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.requiredInput.image
        imageView.image = image
        return imageView
    }()
    
    private let textField: TextField = {
        let textField = TextField()
        textField.textColor = Colors.Gray_15
        textField.font = Font.Typography.body3_R
        textField.backgroundColor = Colors.White
        textField.layer.borderColor = Colors.Gray_5.cgColor
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: "이름을 입력해주세요",
                                                             attributes: attributes)
        return textField
    }()
    
    private let textFieldSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "00/10"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .rounded)
        button.setTitle("수정 완료", for: .normal)
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
        self.backgroundColor = Colors.White
        
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.addSubview(self.textInputTitleLabel)
        self.addSubview(self.myNicknameLabel)
        self.addSubview(self.newTextInputTitleLabel)
        self.addSubview(self.requiredImage)
        self.addSubview(self.textField)
        self.addSubview(self.textFieldSubTitleLabel)
        self.addSubview(self.countLabel)
        self.addSubview(self.confirmButton)
        
        self.textInputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.equalToSuperview().inset(Metric.basePadding)
        }
        
        self.myNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(self.textInputTitleLabel.snp.bottom).offset(Metric.nicknameTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.basePadding)
        }
        
        self.newTextInputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.myNicknameLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalToSuperview().inset(Metric.basePadding)
        }
        
        self.requiredImage.snp.makeConstraints {
            $0.top.equalTo(myNicknameLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalTo(self.newTextInputTitleLabel.snp.trailing).offset(Metric.requiredLeftSpacing)
        }
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(self.newTextInputTitleLabel.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.basePadding)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.textFieldSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.textField.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.basePadding)
        }
        
        self.countLabel.snp.makeConstraints {
            $0.top.equalTo(self.textField.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countRightMargin)
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(Metric.buttonBottomMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.basePadding)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
}
