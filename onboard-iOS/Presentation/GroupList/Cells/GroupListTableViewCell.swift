//
//  GroupListTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/15/24.
//

import UIKit

final class GroupListTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body2_R
        return label
    }()
}
