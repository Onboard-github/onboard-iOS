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
}
