//
//  MemberManageTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class MemberManageTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private let titleImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.dice.image
        imageView.image = image
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLabels.member_delete, for: .normal)
        button.setTitleColor(Colors.Orange_10, for: .normal)
        button.titleLabel?.font = Font.Typography.body5_R
        return button
    }()
}
