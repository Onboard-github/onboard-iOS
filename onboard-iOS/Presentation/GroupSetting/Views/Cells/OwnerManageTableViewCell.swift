//
//  OwnerManageTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/10/24.
//

import UIKit

final class OwnerManageTableViewCell: UITableViewCell {
    
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
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.setImage(IconImage.selected.image, for: .normal)
        return button
    }()
}
