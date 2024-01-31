//
//  GroupCreateView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/26.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class GroupCreateView: UIView {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 120
        static let imageViewWidth: CGFloat = 138
        static let imageViewHeight: CGFloat = 182
        static let imageViewButtonLayout: CGFloat = 10
        static let imageViewButtonSize: CGFloat = 28
        static let nameTopSpacing: CGFloat = 40
        static let leftRightMargin: CGFloat = 24
        static let requiredSpacing: CGFloat = 2
        static let inputTopSpacing: CGFloat = 5
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
        label.text = TextLabels.group_name
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        label.numberOfLines = 0
        return label
    }()
    
    private let nameRequiredImage: UIImageView = {
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
        label.text = TextLabels.group_name_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    /* 그룹 소개 */
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_description
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let descriptionRequiredImage: UIImageView = {
        let image = UIImageView()
        let iconImage = IconImage.requiredInput
        image.image = iconImage.image
        return image
    }()
    
    private lazy var descriptionTextView: TextView = {
        let textView = TextView()
        textView.textColor = Colors.Gray_15
        textView.font = Font.Typography.body3_R
        textView.placeholder = TextLabels.group_description_placeholder
        textView.delegate = self
        return textView
    }()
    
    private let descriptionCountLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_description_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    /* 소속 */
    
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_organization
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let organizationTextField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.layer.borderColor = Colors.Gray_5.cgColor
        return text
    }()
    
    private let organizationCountLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_organization_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let registerButton: BaseButton = {
        let button = BaseButton(status: .default, style: .rounded)
        button.setTitle(TextLabels.group_register, for: .normal)
        return button
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
        self.setupTextField()
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
        nameTextField.attributedPlaceholder = NSAttributedString(string: TextLabels.group_name_placeholder,
                                                                 attributes: attributes)
        organizationTextField.attributedPlaceholder = NSAttributedString(string: TextLabels.group_organization_placeholder,
                                                                         attributes: attributes)
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleImageView)
        self.titleImageView.addSubview(self.titleImageViewButton)
        
        self.addSubview(self.nameLabel)
        self.addSubview(self.nameRequiredImage)
        self.addSubview(self.nameTextField)
        self.addSubview(self.nameCountLabel)
        
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.descriptionRequiredImage)
        self.addSubview(self.descriptionTextView)
        self.addSubview(self.descriptionCountLabel)
        
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
        
        /* 그룹 이름 */
        
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(Metric.nameTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.nameRequiredImage.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(Metric.nameTopSpacing)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(Metric.requiredSpacing)
        }
        
        self.nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Metric.inputTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.nameCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Metric.countLabelTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countLabelRightSpacing)
        }
        
        /* 그룹 소개 */
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameCountLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.descriptionRequiredImage.snp.makeConstraints {
            $0.top.equalTo(nameCountLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalTo(descriptionLabel.snp.trailing).offset(Metric.requiredSpacing)
        }
        
        self.descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Metric.inputTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.textViewHeight)
        }
        
        self.descriptionCountLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(Metric.countLabelTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countLabelRightSpacing)
        }
        
        /* 소속(선택) */
        
        self.organizationStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionCountLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.organizationTextField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.organizationCountLabel.snp.makeConstraints {
            $0.top.equalTo(organizationStackView.snp.bottom).offset(Metric.countLabelTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.countLabelRightSpacing)
        }
        
        /* 등록하기 */
        
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(organizationCountLabel.snp.bottom).offset(Metric.buttonTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    private func updateCountLabel(characterCount: Int) {
        self.descriptionCountLabel.text = "\(characterCount)/\(TextLabels.group_description_maxCount)"
    }
}

// MARK: - TextField

extension GroupCreateView {
    
    private func setupTextField() {
        self.nameTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 14
                let updatedText = String(text.prefix(maxLength))
                self?.nameCountLabel.text = "\(String(format: "%02d", updatedText.count))/\(maxLength)"
                self?.nameTextField.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
            })
            .disposed(by: disposeBag)
        
        self.organizationTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 15
                let updatedText = String(text.prefix(maxLength))
                self?.organizationCountLabel.text = "\(String(format: "%02d", updatedText.count))/\(maxLength)"
                self?.organizationTextField.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
            })
            .disposed(by: disposeBag)
        
        Observable.merge(
            self.nameTextField.rx.controlEvent(.editingDidBegin).map { true },
            self.nameTextField.rx.controlEvent(.editingDidEnd).map { false }
        )
        .subscribe(onNext: { [weak self] isEditing in
            self?.handleTextFieldEditing(isEditing: isEditing, textField: self?.nameTextField)
        })
        .disposed(by: disposeBag)
        
        Observable.merge(
            self.organizationTextField.rx.controlEvent(.editingDidBegin).map { true },
            self.organizationTextField.rx.controlEvent(.editingDidEnd).map { false }
        )
        .subscribe(onNext: { [weak self] isEditing in
            self?.handleTextFieldEditing(isEditing: isEditing, textField: self?.organizationTextField)
        })
        .disposed(by: disposeBag)
    }
    
    private func handleTextFieldEditing(isEditing: Bool, textField: UITextField?) {
        textField?.layer.borderColor = isEditing ? Colors.Gray_7.cgColor : Colors.Gray_5.cgColor
    }
}

// MARK: - UITextViewDelegate

extension GroupCreateView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TextLabels.group_description_placeholder {
            textView.text = nil
            textView.textColor = Colors.Gray_15
        }
        
        textView.layer.borderColor = Colors.Gray_7.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = TextLabels.group_description_placeholder
            textView.textColor = Colors.Gray_7
            updateCountLabel(characterCount: 0)
        }
        
        textView.layer.borderColor = Colors.Gray_5.cgColor
        
        if let description = textView.text {
            GroupCreateManager.saveDescription(description)
        }
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
            
            let count = String(format: "%02d", characterCount)
            updateCountLabel(characterCount: characterCount)
            
            descriptionCountLabel.text = "\(count)/\(maxLength)"
            
            return true
        }
}
