//
//  GroupCreateView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/26.
//

import UIKit
import ReactorKit

final class GroupCreateView: UIView {
    
    private let button = Button()
    
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
        image.image = UIImage(named: "img_diceBgGreen")
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    private let titleImageViewButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(IconImage.galleryDefault.image, for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "보드게임 모임 이름"
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
    
    private let nameTextField: UITextField = {
        let text = UITextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.tintColor = Colors.Orange_8
        text.backgroundColor = Colors.Gray_2
        text.borderStyle = .roundedRect
        text.layer.cornerRadius = 8
        text.layer.borderWidth = 1.0
        text.layer.borderColor = Colors.Gray_5.cgColor
        return text
    }()
    
    private let nameCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/14"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let introdutionLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 소개"
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
        view.text = "모임을 소개해주세요."
        view.textColor = Colors.Gray_7
        view.font = Font.Typography.body3_R
        view.backgroundColor = Colors.Gray_2
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Colors.Gray_5.cgColor
        return view
    }()
    
    private let introductionCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/72"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let affiliationLabel: UILabel = {
        let label = UILabel()
        label.text = "소속 (선택)"
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let affiliationTextField: UITextField = {
        let text = UITextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.tintColor = Colors.Orange_8
        text.backgroundColor = Colors.Gray_2
        text.borderStyle = .roundedRect
        text.layer.cornerRadius = 8
        text.layer.borderWidth = 1.0
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
    
    private lazy var registerButton: UIButton = {
        let button = button.disabled
        button.setTitle("모임 등록하기", for: .normal)
        button.isEnabled = false
        return button
    }()
    
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
        let view = UIStackView(arrangedSubviews: [introdutionLabel, introdutionEssentialImage])
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
}

extension GroupCreateView: UITextFieldDelegate {
    
}
