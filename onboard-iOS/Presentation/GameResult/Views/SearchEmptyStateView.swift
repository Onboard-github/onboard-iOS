//
//  SearchEmptyStateView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/22/24.
//

import UIKit

final class SearchEmptyStateView: UIView {
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_11
        label.font = Font.Typography.body2_M
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_10
        label.font = Font.Typography.body3_R
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addGuest"), for: .normal)
        return button
    }()
}
