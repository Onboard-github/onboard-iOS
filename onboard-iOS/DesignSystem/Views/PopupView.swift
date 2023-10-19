//
//  PopupView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/14.
//

import UIKit
import SnapKit

class PopupView: UIView {
    
    private let buttons = Buttons()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        return label
    }()
    
    private let linkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Font.Typography.body5_R
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        label.numberOfLines = 0
        return label
    }()
    
    private let textFieldTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_13
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let textField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body2_M
        return text
    }()
    
    private let textFieldSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private lazy var registerButton = buttons.defaultButton
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, linkButton])
        view.spacing = 18
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [headerStackView, subTitleLabel])
        view.spacing = 2
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [textFieldTitleLabel, textField, bottomStackView])
        view.spacing = 2
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [textFieldSubTitleLabel, countLabel])
        view.spacing = 10
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTextField()
        makeConstraints()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField() {
        textField.delegate = self
    }
    
    private func makeConstraints() {
        self.addSubview(self.backgroundView)
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.titleStackView)
        self.contentView.addSubview(self.textFieldStackView)
        self.contentView.addSubview(self.registerButton)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        self.textField.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        self.textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(20)
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    func setState(popupState: PopupState,
                  onClickLink: @escaping (() -> Void)) {
        
        titleLabel.text = popupState.titleLabel
        subTitleLabel.text = popupState.subTitleLabel
        textFieldTitleLabel.text = popupState.textFieldLabelState?.string ?? ""
        textFieldSubTitleLabel.text = popupState.textFieldSubTitleLabel
        countLabel.text = popupState.countLabel
        registerButton.setTitle(popupState.buttonLabel, for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body2_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: popupState.textFieldPlaceholder,
                                                             attributes: attributes)
        
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor: Colors.Gray_9,
            NSAttributedString.Key.baselineOffset: 2
        ]
        linkButton.setAttributedTitle(NSAttributedString(string: popupState.linkButtonState?.string ?? "",
                                                         attributes: buttonAttributes), for: .normal)
    }
    
    @objc
    private func backgroundTapped() {
        removeFromSuperview()
    }
}

extension PopupView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            
            let maxLength = 10
            
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            
            if newLength <= maxLength {
                self.countLabel.text = "\(newLength)/\(maxLength)"
                return true
            } else {
                return false
            }
        }
}
