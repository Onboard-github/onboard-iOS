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
        static let nameTopSpacing: CGFloat = 40
        static let leftRightMargin: CGFloat = 24
        static let textFieldHeight: CGFloat = 48
        static let countLabelTopSpacing: CGFloat = 5
        static let countLabelRightSpacing: CGFloat = 30
        static let itemSpacing: CGFloat = 15
        static let textViewHeight: CGFloat = 88
        static let buttonTopMargin: CGFloat = 20
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    let titleImageView: UIImageView = {
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
    
    private let requiredImage: UIImageView = {
        let image = UIImageView()
        let iconImage = IconImage.requiredInput
        image.image = iconImage.image
        return image
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
    
    private lazy var nameTextField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.layer.borderColor = Colors.Gray_5.cgColor
        text.delegate = self
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
    
    private lazy var introductionTextView: TextView = {
        let textView = TextView()
        textView.textColor = Colors.Gray_15
        textView.font = Font.Typography.body3_R
        textView.placeholder = " 그룹을 소개해주세요."
        textView.delegate = self
        return textView
    }()
    
    private let introductionCountLabel: UILabel = {
        let label = UILabel()
        label.text = "00/72"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    /* 소속 */
    
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.text = "소속(선택)"
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private lazy var organizationTextField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.layer.borderColor = Colors.Gray_5.cgColor
        text.delegate = self
        return text
    }()
    
    private let organizationCountLabel: UILabel = {
        let label = UILabel()
        label.text = "00/15"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let registerButton: BaseButton = {
        let button = BaseButton(status: .default, style: .rounded)
        button.setTitle("그룹 등록하기", for: .normal)
        return button
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [nameLabel, requiredImage.clone()])
        stview.axis = .horizontal
        stview.spacing = 2
        stview.distribution = .equalSpacing
        stview.alignment = .top
        
        let stackView = UIStackView(arrangedSubviews: [stview, nameTextField])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var introductionStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [introductionLabel, requiredImage.clone()])
        stview.axis = .horizontal
        stview.spacing = 2
        stview.distribution = .equalCentering
        stview.alignment = .top
        
        let stackView = UIStackView(arrangedSubviews: [stview, introductionTextView])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var organizationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [organizationLabel, organizationTextField])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Properties
    
    var didImageViewButton: (() -> Void)?
    var didTapRegisterButton: (() -> Void)?
    
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
        self.backgroundColor = Colors.Gray_2
        
        self.addConfigure()
        self.textFieldPlaceHolder()
        self.makeConstraints()
        self.setupGestureRecognizer()
    }
    
    private func addConfigure() {
        self.titleImageViewButton.addAction(UIAction(handler: { _ in
            self.didImageViewButton?()
        }), for: .touchUpInside)
        
        self.registerButton.addAction(UIAction(handler: { _ in
            self.didTapRegisterButton?()
        }), for: .touchUpInside)
    }
    
    private func textFieldPlaceHolder() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        nameTextField.attributedPlaceholder = NSAttributedString(string: "그룹 이름을 입력해주세요.",
                                                                 attributes: attributes)
        organizationTextField.attributedPlaceholder = NSAttributedString(string: "Ex) 홍익대학교",
                                                                        attributes: attributes)
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleImageView)
        self.titleImageView.addSubview(self.titleImageViewButton)
        
        self.addSubview(self.nameStackView)
        self.addSubview(self.nameCountLabel)
        
        self.addSubview(self.introductionStackView)
        self.addSubview(self.introductionCountLabel)
        
        self.addSubview(self.organizationStackView)
        self.addSubview(self.organizationCountLabel)
        
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
        
        self.nameStackView.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(Metric.nameTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.nameTextField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.nameCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameStackView.snp.bottom).offset(Metric.countLabelTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countLabelRightSpacing)
        }
        
        self.introductionStackView.snp.makeConstraints {
            $0.top.equalTo(nameCountLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.introductionTextView.snp.makeConstraints {
            $0.height.equalTo(Metric.textViewHeight)
        }
        
        self.introductionCountLabel.snp.makeConstraints {
            $0.top.equalTo(introductionStackView.snp.bottom).offset(Metric.countLabelTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countLabelRightSpacing)
        }
        
        self.organizationStackView.snp.makeConstraints {
            $0.top.equalTo(introductionCountLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.organizationTextField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.organizationCountLabel.snp.makeConstraints {
            $0.top.equalTo(organizationStackView.snp.bottom).offset(Metric.countLabelTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countLabelRightSpacing)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(organizationCountLabel.snp.bottom).offset(Metric.buttonTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.addGestureRecognizer(tapGesture)
    }
    
    private func updateCountLabel(characterCount: Int) {
        self.introductionCountLabel.text = "\(characterCount)/72"
    }
    
    @objc
    private func backgroundTapped() {
        self.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension GroupCreateView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
            if textField == nameTextField || textField == organizationTextField {
                let currentText = textField.text ?? ""
                let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
                
                let maxLength = (textField == nameTextField) ? 14 : 15
                let countLabel = (textField == nameTextField) ? nameCountLabel : organizationCountLabel
                
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
        if textView.text == "그룹을 소개해주세요." {
            textView.text = nil
            textView.textColor = Colors.Gray_15
        }
        
        textView.layer.borderColor = Colors.Gray_7.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "그룹을 소개해주세요."
            textView.textColor = Colors.Gray_7
            updateCountLabel(characterCount: 0)
        }
        
        textView.layer.borderColor = Colors.Gray_5.cgColor
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String) -> Bool {
            
            let newString = (textView.text as NSString)
                .replacingCharacters(in: range, with: text)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            let characterCount = newString.count
            let maxLength = 72
            
            guard characterCount <= maxLength else {
                return false
            }
            
            updateCountLabel(characterCount: characterCount)
            return true
        }
}

// MARK: - UIImageView

extension UIImageView {
    func clone() -> UIImageView {
        let cloneImageView = UIImageView(image: self.image)
        
        return cloneImageView
    }
}
