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
}
