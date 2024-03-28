//
//  MyProfileView.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/28/24.
//

import UIKit

final class MyProfileView: UIView {
    
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
}
