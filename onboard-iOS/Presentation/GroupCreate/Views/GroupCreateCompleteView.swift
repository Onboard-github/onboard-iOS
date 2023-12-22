//
//  GroupCreateCompleteView.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/21/23.
//

import UIKit

final class GroupCreateCompleteView: UIView {
    
    // MARK: - UI
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let completeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_complete_text
        label.textColor = Colors.Orange_8
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.text = GroupCreateManager.shared.getOrganization()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = GroupCreateManager.shared.getName()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.headLine
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = GroupCreateManager.shared.getDescription()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.body3_R
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
        label.textColor = Colors.Gray_7
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.title3
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
        label.textColor = Colors.Gray_7
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let accessCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.title3
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        let image = IconImage.copy
        button.setImage(image.image, for: .normal)
        return button
    }()
    
    private let inviteLabel: UILabel = {
       let label = UILabel()
        label.text = TextLabels.group_invite_text
        label.textColor = Colors.Orange_5
        label.font = Font.Typography.body4_R
        label.numberOfLines = 0
        return label
    }()
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .default, style: .rounded)
        button.setTitle(TextLabels.confirm_text, for: .normal)
        return button
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [organizationLabel, nameLabel, descriptionLabel])
        stview.axis = .vertical
        stview.spacing = 7
        return stview
    }()
    
    private lazy var managerStackView: UIStackView = {
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
        stview.spacing = 5
        return stview
    }()
}
