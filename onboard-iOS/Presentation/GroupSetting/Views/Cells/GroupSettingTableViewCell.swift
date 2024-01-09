//
//  GroupSettingTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class GroupSettingTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body2_R
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
}
