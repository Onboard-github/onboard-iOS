//
//  AccessCodeView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class AccessCodeView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 35
        static let leftMagin: CGFloat = 20
        static let codeTopSpacing: CGFloat = 10
        static let itemSpacing: CGFloat = 30
        static let requiredLeftSpacing: CGFloat = 2
        static let textFieldTopSpacing: CGFloat = 5
        static let textFieldHeight: CGFloat = 48
        static let countRightMargin: CGFloat = 30
    }
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_current
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_code
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title3
        return label
    }()
    
    private let newTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_new
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let requiredImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.requiredInput
        imageView.image = image.image
        return imageView
    }()
    
    private lazy var textField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.layer.borderColor = Colors.Gray_7.cgColor
        text.backgroundColor = Colors.White
        text.keyboardType = .default
        text.delegate = self
        return text
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_subTitle
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.backgroundColor = Colors.White
        
        self.textFieldPlaceHolder()
        self.makeConstraints()
        self.setupGestureRecognizer()
    }
    
    private func textFieldPlaceHolder() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: TextLabels.access_placeholder,
                                                             attributes: attributes)
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.codeLabel)
        self.addSubview(self.newTitleLabel)
        self.addSubview(self.requiredImage)
        self.addSubview(self.textField)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.countLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.equalToSuperview().inset(Metric.leftMagin)
        }
        
        self.codeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.codeTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftMagin)
        }
        
        self.newTitleLabel.snp.makeConstraints {
            $0.top.equalTo(codeLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftMagin)
        }
        
        self.requiredImage.snp.makeConstraints {
            $0.top.equalTo(codeLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalTo(newTitleLabel.snp.trailing).offset(Metric.requiredLeftSpacing)
        }
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(newTitleLabel.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftMagin)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftMagin)
        }
        
        self.countLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countRightMargin)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func backgroundTapped() {
        self.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension AccessCodeView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
            guard textField === self.textField,
                  let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string),
                  newText.rangeOfCharacter(from: CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").inverted) == nil else {
                return true
            }
            
            let maxLength = 6
            
            if newText.count <= maxLength {
                countLabel.text = "\(String(format: TextLabels.access_currentCount, newText.count))/\(maxLength)"
                return true
            } else {
                return false
            }
        }
}
