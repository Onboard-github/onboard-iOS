//
//  GroupInfoDetailView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

final class GroupInfoDetailView: UIView {
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_1
        view.layer.cornerRadius = 0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        label.numberOfLines = 0
        return label
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(IconImage.settingDefault.image, for: .normal)
        return button
    }()
    
    private let groupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_12
        label.font = Font.Typography.body3_R
        label.numberOfLines = 0
        return label
    }()
    
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let memberImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.member
        imageView.image = image.image
        return imageView
    }()
    
    private let memberLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_member_countText
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let memberNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let ownerImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.manager
        imageView.image = image.image
        return imageView
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_owner_text
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let codeImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.code
        imageView.image = image.image
        return imageView
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.text =  TextLabels.group_accessCode_text
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let accessCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        let image = IconImage.copyDefault
        button.setImage(image.image, for: .normal)
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.White
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.Gray_2.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private let profileDiceImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.dice.image
        imageView.image = image
        return imageView
    }()
    
    private let meImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.me.image
        imageView.image = image
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let playCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let modifyButton: UIButton = {
        let button = UIButton()
        button.setImage(IconImage.eyeDefault.image, for: .normal)
        return button
    }()
    
    private let divView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
    
    private let exitImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.circleX.image
        imageView.image = image
        return imageView
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLabels.exit_text, for: .normal)
        button.setTitleColor(Colors.Gray_10, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_M
        return button
    }()
    
    private lazy var memberStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [memberImage, memberLabel])
        stview.axis = .horizontal
        stview.spacing = 7
        return stview
    }()
    
    private lazy var ownerStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [ownerImage, ownerLabel])
        stview.axis = .horizontal
        stview.spacing = 7
        return stview
    }()
    
    private lazy var codeStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [codeImage, codeLabel])
        stview.axis = .horizontal
        stview.spacing = 7
        return stview
    }()
    
    private lazy var copyStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [accessCodeLabel, copyButton])
        stview.axis = .horizontal
        stview.spacing = 7
        return stview
    }()
    
    private lazy var meStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [meImage, nicknameLabel])
        stview.axis = .horizontal
        stview.spacing = 5
        return stview
    }()
    
    private lazy var exitStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [exitImage, exitButton])
        stview.axis = .horizontal
        stview.spacing = 5
        return stview
    }()
}
