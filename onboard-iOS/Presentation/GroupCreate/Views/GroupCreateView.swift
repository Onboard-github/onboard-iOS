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
    
    private var isKeyboardAdjusted = false
    
    var didImageViewButton: (() -> Void)?
    var didTapRegisterButton: (() -> Void)?
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 10
        static let imageViewWidth: CGFloat = 138
        static let imageViewHeight: CGFloat = 182
        static let imageViewButtonLayout: CGFloat = 10
        static let imageViewButtonSize: CGFloat = 28
        static let nameTopSpacing: CGFloat = 15
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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let titleImageView: UIImageView = {
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
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        text.attributedPlaceholder = NSAttributedString(string: TextLabels.group_name_placeholder,
                                                        attributes: attributes)
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
    
    private let descriptionTextView: TextView = {
        let textView = TextView()
        textView.textColor = Colors.Gray_15
        textView.font = Font.Typography.body3_R
        textView.placeholder = TextLabels.group_description_placeholder
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
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        text.attributedPlaceholder = NSAttributedString(string: TextLabels.group_organization_placeholder,
                                                        attributes: attributes)
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
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Bind
    
    func bind(image: UIImage?) {
        guard let image = image else { return }
        self.titleImageView.image = image
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.backgroundColor = Colors.Gray_2
        
        self.addConfigure()
        self.makeConstraints()
        self.setButtonStatus()
        
        self.setupTextField()
        self.setupTextView()
        
        self.setGestureRecognizer()
    }
    
    private func addConfigure() {
        self.titleImageViewButton.addAction(UIAction(handler: { _ in
            self.didImageViewButton?()
        }), for: .touchUpInside)
        
        self.registerButton.addAction(UIAction(handler: { _ in
            self.didTapRegisterButton?()
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.addSubview(self.scrollView)
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
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.titleImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Metric.topMargin)
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
    
    private func setButtonStatus() {
        let nameTextFieldObservable = nameTextField.rx.text.orEmpty
            .map { $0.count >= 1 }
        
        let textViewObservable = descriptionTextView.rx.text.orEmpty
            .map { $0.count >= 1 }
        
        let observable = Observable.combineLatest(nameTextFieldObservable, textViewObservable)
            .map { nameIsValid, descriptionIsValid in
                return nameIsValid && descriptionIsValid
            }
        
        observable
            .subscribe(onNext: { [weak self] isInputValid in
                self?.registerButton.status = isInputValid ? .default : .disabled
            })
            .disposed(by: disposeBag)
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
                
                GroupCreateSingleton.shared.nameText.accept(text)
            })
            .disposed(by: disposeBag)
        
        self.organizationTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 15
                let updatedText = String(text.prefix(maxLength))
                self?.organizationCountLabel.text = "\(String(format: "%02d", updatedText.count))/\(maxLength)"
                self?.organizationTextField.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
                
                GroupCreateSingleton.shared.organizationText.accept(text)
            })
            .disposed(by: disposeBag)
        
        self.nameTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.nameTextField.text, text.isEmpty else { return }
                self?.nameTextField.layer.borderColor = Colors.Gray_7.cgColor
            })
            .disposed(by: disposeBag)
        
        self.nameTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.nameTextField.text, text.isEmpty else { return }
                self?.nameTextField.layer.borderColor = Colors.Gray_5.cgColor
            })
            .disposed(by: disposeBag)
        
        self.organizationTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.organizationTextField.text, text.isEmpty else { return }
                self?.organizationTextField.layer.borderColor = Colors.Gray_7.cgColor
            })
            .disposed(by: disposeBag)
        
        self.organizationTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.organizationTextField.text, text.isEmpty else { return }
                self?.organizationTextField.layer.borderColor = Colors.Gray_5.cgColor
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - TextView

extension GroupCreateView {
    
    private func setupTextView() {
        self.descriptionTextView.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 72
                let updatedText = String(text.prefix(maxLength))
                self?.descriptionCountLabel.text = "\(String(format: "%02d", updatedText.count))/\(maxLength)"
                self?.descriptionTextView.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
                
                GroupCreateSingleton.shared.descriptionText.accept(text)
            })
            .disposed(by: disposeBag)
        
        self.descriptionTextView.rx.didBeginEditing
            .subscribe(onNext: { [weak self] in
                guard let text = self?.descriptionTextView.text, text.isEmpty else { return }
                self?.descriptionTextView.layer.borderColor = Colors.Gray_7.cgColor
            })
            .disposed(by: disposeBag)
        
        self.descriptionTextView.rx.didEndEditing
            .subscribe(onNext: { [weak self] in
                guard let text = self?.descriptionTextView.text, text.isEmpty else { return }
                self?.descriptionTextView.layer.borderColor = Colors.Gray_5.cgColor
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - GestureRecognizer

extension GroupCreateView {
    
    private func setGestureRecognizer() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        self.organizationTextField.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func textFieldTapped() {
        self.organizationTextField.becomeFirstResponder()
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              !self.isKeyboardAdjusted else {
            return
        }
        
        let labelMaxY = self.organizationCountLabel.frame.maxY
        let keyboardMinY = keyboardSize.minY
        
        guard labelMaxY > keyboardMinY else {
            return
        }
        
        let offset = labelMaxY - keyboardMinY + 30
        
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y -= offset
        }
        
        self.isKeyboardAdjusted = true
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = 0
        }
        
        self.isKeyboardAdjusted = false
    }
}
