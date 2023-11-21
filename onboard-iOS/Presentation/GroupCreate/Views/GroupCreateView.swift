//
//  GroupCreateView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/26.
//

import UIKit
import ReactorKit

final class GroupCreateView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 120
        static let imageViewWidth: CGFloat = 138
        static let imageViewHeight: CGFloat = 182
        static let imageViewButtonLayout: CGFloat = 10
        static let imageViewButtonSize: CGFloat = 28
        static let essentialImageSize: CGFloat = 8
        static let fieldTopMargin: CGFloat = 40
        static let leftRightMargin: CGFloat = 24
        static let textFieldHeight: CGFloat = 48
        static let countLabelTopMargin: CGFloat = 5
        static let spacingField: CGFloat = 15
        static let textViewHeight: CGFloat = 88
        static let buttonTopMargin: CGFloat = 20
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    private let titleImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img_diceBgSkyblue")
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let titleImageViewButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(IconImage.galleryDefault.image, for: .normal)
        return button
    }()
    
    /* 그룹 이름 */
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "그룹 이름"
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        label.numberOfLines = 0
        return label
    }()
    
    private let nameEssentialImage: UIImageView = {
        let image = UIImageView()
        let iconImage = IconImage.requiredInput
        image.image = iconImage.image
        return image
    }()
    
    private let nameTextField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.layer.borderColor = Colors.Gray_5.cgColor
        return text
    }()
    
    private let nameCountLabel: UILabel = {
        let label = UILabel()
        label.text = "00/14"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    /* 그룹 소개 */
    
    private let introductionLabel: UILabel = {
        let label = UILabel()
        label.text = "그룹 소개"
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let introdutionEssentialImage: UIImageView = {
        let image = UIImageView()
        let iconImage = IconImage.requiredInput
        image.image = iconImage.image
        return image
    }()
    
    private lazy var introductionTextView: UITextView = {
        let view = UITextView()
        view.text = "그룹을 소개해주세요."
        view.textColor = Colors.Gray_7
        view.font = Font.Typography.body3_R
        view.backgroundColor = Colors.Gray_2
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Colors.Gray_5.cgColor
        view.tintColor = Colors.Orange_8
        view.delegate = self
        return view
    }()
    
    private let introductionCountLabel: UILabel = {
        let label = UILabel()
        label.text = "00/72"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    /* 소속 */
    
    private let affiliationLabel: UILabel = {
        let label = UILabel()
        label.text = "소속(선택)"
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let affiliationTextField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.layer.borderColor = Colors.Gray_5.cgColor
        return text
    }()
    
    private let affiliationCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/15"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private var registerButton = BaseButton(status: .disabled, style: .rounded)
    
    private lazy var nameTitleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, nameEssentialImage])
        view.spacing = 1
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    
    private lazy var nameStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameTitleStackView, nameTextField])
        view.spacing = 5
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var introductionTitleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [introductionLabel, introdutionEssentialImage])
        view.spacing = 1
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    
    private lazy var introductionStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [introductionTitleStackView, introductionTextView])
        view.spacing = 5
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var affiliationStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [affiliationLabel, affiliationTextField])
        view.spacing = 5
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        textFieldPlaceHolder()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.backgroundColor = Colors.Gray_2
        
        nameTextField.delegate = self
        affiliationTextField.delegate = self
        
        registerButton.setTitle("그룹 등록하기", for: .normal)
    }
    
    private func textFieldPlaceHolder() {
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        nameTextField.attributedPlaceholder = NSAttributedString(string: "그룹 이름을 입력해주세요.",
                                                                 attributes: nameAttributes)
        
        let affAttributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        affiliationTextField.attributedPlaceholder = NSAttributedString(string: "Ex) 홍익대학교",
                                                                        attributes: affAttributes)
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleImageView)
        self.titleImageView.addSubview(self.titleImageViewButton)
        
        self.addSubview(self.nameCountLabel)
        self.addSubview(self.nameStackView)
        
        self.addSubview(self.introductionCountLabel)
        self.addSubview(self.introductionStackView)
        
        self.addSubview(self.affiliationCountLabel)
        self.addSubview(self.affiliationStackView)
        
        self.addSubview(self.registerButton)
        
        self.titleImageView.snp.makeConstraints {
            $0.top.equalTo(Metric.topMargin)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Metric.imageViewWidth)
            $0.height.equalTo(Metric.imageViewHeight)
        }
        
        self.titleImageViewButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(-Metric.imageViewButtonLayout)
            $0.width.height.equalTo(Metric.imageViewButtonSize)
        }
        
        self.nameEssentialImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.essentialImageSize)
        }
        
        self.nameStackView.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(Metric.fieldTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.nameTextField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.nameCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameStackView.snp.bottom).offset(Metric.countLabelTopMargin)
            $0.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.introdutionEssentialImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.essentialImageSize)
        }
        
        self.introductionStackView.snp.makeConstraints {
            $0.top.equalTo(nameCountLabel.snp.bottom).offset(Metric.spacingField)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.introductionTextView.snp.makeConstraints {
            $0.height.equalTo(Metric.textViewHeight)
        }
        
        self.introductionCountLabel.snp.makeConstraints {
            $0.top.equalTo(introductionStackView.snp.bottom).offset(Metric.countLabelTopMargin)
            $0.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.affiliationStackView.snp.makeConstraints {
            $0.top.equalTo(introductionCountLabel.snp.bottom).offset(Metric.spacingField)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.affiliationTextField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.affiliationCountLabel.snp.makeConstraints {
            $0.top.equalTo(affiliationStackView.snp.bottom).offset(Metric.countLabelTopMargin)
            $0.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(affiliationCountLabel.snp.bottom).offset(Metric.buttonTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    private func updateCountLabel(characterCount: Int) {
        self.introductionCountLabel.text = "\(characterCount)/72"
    }
}

// MARK: - UITextFieldDelegate

extension GroupCreateView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
            if textField == nameTextField || textField == affiliationTextField {
                let currentText = textField.text ?? ""
                let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
                
                let maxLength = (textField == nameTextField) ? 14 : 15
                let countLabel = (textField == nameTextField) ? nameCountLabel : affiliationCountLabel
                
                if updatedText.count <= maxLength {
                    countLabel.text = "\(updatedText.count)/\(maxLength)"
                    return true
                } else {
                    return false
                }
            }
            return true
        }
    
    func textFieldDidBeginEditing(
        _ textField: UITextField) {
            textField.layer.borderColor = Colors.Gray_7.cgColor
        }
    
    func textFieldDidEndEditing(
        _ textField: UITextField,
        reason: UITextField.DidEndEditingReason) {
            textField.layer.borderColor = Colors.Gray_5.cgColor
        }
}

// MARK: - UITextViewDelegate

extension GroupCreateView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "모임을 소개해주세요." {
            textView.text = nil
            textView.textColor = Colors.Gray_15
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "모임을 소개해주세요."
            textView.textColor = Colors.Gray_7
            updateCountLabel(characterCount: 0)
        }
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String) -> Bool {
            
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            
            let newString = (textView.text as NSString).replacingCharacters(in: range, with: text).trimmingCharacters(in: .whitespacesAndNewlines)
            
            let characterCount = newString.count
            let maxLength = 72
            
            guard characterCount <= maxLength else {
                return false
            }
            
            updateCountLabel(characterCount: characterCount)
            return true
        }
}
