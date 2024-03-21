//
//  AccessCodeView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit
import RxSwift
import RxCocoa

final class AccessCodeView: UIView {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
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
        static let buttonBottomMargin: CGFloat = 10
        static let buttonHeight: CGFloat = 48
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
        text.keyboardType = .asciiCapable
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        text.attributedPlaceholder = NSAttributedString(string: TextLabels.access_placeholder,
                                                        attributes: attributes)
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
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .rounded)
        button.setTitle(TextLabels.access_confirm, for: .normal)
        return button
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
    
    func bind(text: String) {
        self.codeLabel.text = "\(text)"
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.backgroundColor = Colors.White
        
        self.makeConstraints()
        self.setupGestureRecognizer()
        
        self.setupTextField()
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.codeLabel)
        self.addSubview(self.newTitleLabel)
        self.addSubview(self.requiredImage)
        self.addSubview(self.textField)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.countLabel)
        self.addSubview(self.confirmButton)
        
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
        
        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(Metric.buttonBottomMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftMagin)
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
    
    @objc
    private func backgroundTapped() {
        self.endEditing(true)
    }
}

// MARK: - TextField

extension AccessCodeView {
    
    private func setupTextField() {
        self.textField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 6
                let updatedText = String(text.prefix(maxLength))
                self?.countLabel.text = "\(updatedText.count)/\(maxLength)"
                self?.textField.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
            })
            .disposed(by: disposeBag)
        
        self.textField.rx.text.orEmpty
            .map { $0.prefix(6).filter { $0.isNumber || $0.isLetter }.uppercased() }
            .bind(to: textField.rx.text)
            .disposed(by: disposeBag)
        
        self.textField.rx.text
            .orEmpty
            .map { $0.count == 6 ? .default : .disabled }
            .bind(to: confirmButton.rx.status)
            .disposed(by: disposeBag)
    }
}
