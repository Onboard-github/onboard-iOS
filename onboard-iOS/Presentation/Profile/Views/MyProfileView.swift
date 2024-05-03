//
//  MyProfileView.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/28/24.
//

import UIKit

import RxSwift
import RxCocoa

final class MyProfileView: UIView {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 35
        static let baseMargin: CGFloat = 24
        static let requiredImageLeading: CGFloat = 5
        static let textFieldHeight: CGFloat = 48
        static let stackViewTopSpacing: CGFloat = 10
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    private let groupLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.profile_groupLabel
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title3
        return label
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.profile_nickname
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title3
        return label
    }()
    
    private let newNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.profile_newNickname
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let requiredImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = IconImage.requiredInput.image
        return imageView
    }()
    
    private let nicknameTextField: TextField = {
        let textField = TextField()
        textField.textColor = Colors.Gray_15
        textField.font = Font.Typography.body3_R
        textField.backgroundColor = Colors.White
        textField.layer.borderColor = Colors.Gray_5.cgColor
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: TextLabels.profile_textField_placeholder,
                                                             attributes: attributes)
        return textField
    }()
    
    private let textFieldSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.owner_popup_textFieldSubTitle
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.profile_textField_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .rounded)
        button.setTitle(TextLabels.profile_confirm, for: .normal)
        return button
    }()
    
    private lazy var groupStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [groupLabel, groupNameLabel])
        stview.axis = .vertical
        stview.spacing = 10
        return stview
    }()
    
    private lazy var nicknameStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [nicknameLabel, nickNameLabel])
        stview.axis = .vertical
        stview.spacing = 10
        return stview
    }()
    
    private lazy var newNicknameStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [nicknameTextField, textFieldSubTitleLabel])
        stview.axis = .vertical
        stview.spacing = 7
        return stview
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
    
    func bind(
        group: String,
        nickname: String
    ) {
        self.groupNameLabel.text = group
        self.nickNameLabel.text = nickname
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
            
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.addSubview(self.groupStackView)
        self.addSubview(self.nicknameStackView)
        self.addSubview(self.newNicknameLabel)
        self.addSubview(self.requiredImage)
        self.addSubview(self.newNicknameStackView)
        self.addSubview(self.countLabel)
        self.addSubview(self.confirmButton)
        
        self.groupStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.equalToSuperview().inset(Metric.baseMargin)
        }
        
        self.nicknameStackView.snp.makeConstraints {
            $0.top.equalTo(self.groupStackView.snp.bottom).offset(Metric.topMargin)
            $0.leading.equalToSuperview().inset(Metric.baseMargin)
        }
        
        self.newNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(self.nicknameStackView.snp.bottom).offset(Metric.topMargin)
            $0.leading.equalToSuperview().inset(Metric.baseMargin)
        }
        
        self.requiredImage.snp.makeConstraints {
            $0.top.equalTo(self.newNicknameLabel.snp.top)
            $0.leading.equalTo(self.newNicknameLabel.snp.trailing).offset(Metric.requiredImageLeading)
        }
        
        self.nicknameTextField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.newNicknameStackView.snp.makeConstraints {
            $0.top.equalTo(self.newNicknameLabel.snp.bottom).offset(Metric.stackViewTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.baseMargin)
        }
        
        self.countLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.textFieldSubTitleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(Metric.baseMargin)
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(Metric.baseMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.baseMargin)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
}

// MARK: - TextField

extension MyProfileView {
    
    private func setTextField() {
        self.nicknameTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 10
                let inputText = String(text.prefix(maxLength))
                self?.countLabel.text = "\(String(format: "%02d", inputText.count))/\(maxLength)"
                self?.nicknameTextField.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
                
                OnBoardSingleton.shared.newGroupUserNameText.accept(text)
            })
            .disposed(by: disposeBag)
    }
}
