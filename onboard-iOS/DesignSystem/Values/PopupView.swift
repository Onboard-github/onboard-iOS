//
//  PopupView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/14.
//

import UIKit

class PopupView: UIView {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let contentView: UIView = {
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
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(Colors.Gray_1, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_B
        button.backgroundColor = Colors.Orange_10
        button.layer.cornerRadius = 12
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
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
        let view = UIStackView(arrangedSubviews: [textField, bottomStackView])
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
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        self.addSubview(self.backgroundView)
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.headerStackView)
        self.contentView.addSubview(self.textFieldStackView)
        self.contentView.addSubview(self.registerButton)
        
        self.backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.headerStackView.snp.makeConstraints {
            $0.top.equalTo(26)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
        }
        
        self.textField.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        self.textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(15)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(20)
            $0.bottom.equalTo(0)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            $0.height.equalTo(52)
        }
    }
}
