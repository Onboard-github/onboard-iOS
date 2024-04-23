//
//  UpdateUserInfoView.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/20/24.
//

import UIKit

import RxSwift
import RxCocoa

final class UpdateUserInfoView: UIView {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var didTapButtonAction: (() -> Void)?
    
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
    
    private let textTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.userInfo_textTitle
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let myNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = ProfileManager.profileName
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title3
        return label
    }()
    
    private let newTextInputTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.userInfo_newTextInputTitle
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
            .foregroundColor: Colors.Gray_7
        ]
        textField.attributedPlaceholder = NSAttributedString(
            string: TextLabels.userInfo_textField_placeholder,
            attributes: attributes
        )
        return textField
    }()
    
    private let textFieldSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.userInfo_textField_subTitle
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.userInfo_textField_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .rounded)
        button.setTitle(TextLabels.userInfo_confirm, for: .normal)
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
        
        self.addConfigure()
        self.makeConstraints()
        
        self.setTextField()
    }
    
    private func addConfigure() {
        self.confirmButton.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapButtonAction?()
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.addSubview(self.textTitleLabel)
        self.addSubview(self.myNicknameLabel)
        self.addSubview(self.newTextInputTitleLabel)
        self.addSubview(self.requiredImage)
        self.addSubview(self.textField)
        self.addSubview(self.textFieldSubTitleLabel)
        self.addSubview(self.countLabel)
        self.addSubview(self.confirmButton)
        
        self.textTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.equalToSuperview().inset(Metric.basePadding)
        }
        
        self.myNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(self.textTitleLabel.snp.bottom).offset(Metric.nicknameTopSpacing)
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

// MARK: - TextField

extension UpdateUserInfoView {
    
    private func setTextField() {
        
        self.textField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 10
                self?.countLabel.text = "\(String(format: "%02d", String(text.prefix(maxLength)).count))/\(maxLength)"
                self?.textField.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
                
                OnBoardSingleton.shared.newUserNameText.accept(text)
                
                self?.textFieldSubTitleLabel.textColor = self?.isValidInput(text) == false ? Colors.Gray_8 : Colors.Red
            })
            .disposed(by: disposeBag)
        
        self.textField.rx
            .controlEvent(.editingChanged)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.confirmButton.status = !(self.textField.text?.isEmpty ?? true) && !(self.isValidInput(self.textField.text)) ? .default : .disabled
            })
            .disposed(by: disposeBag)
    }
    
    private func isValidInput(_ text: String?) -> Bool {
        let excludeCharacter = CharacterSet(charactersIn: TextLabels.exclude_string)
        return text?.rangeOfCharacter(from: excludeCharacter) != nil
    }
}
