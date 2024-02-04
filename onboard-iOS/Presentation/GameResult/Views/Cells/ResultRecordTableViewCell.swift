//
//  ResultRecordTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/3/24.
//

import UIKit

final class ResultRecordTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let titleImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body5_R
        return label
    }()
}
