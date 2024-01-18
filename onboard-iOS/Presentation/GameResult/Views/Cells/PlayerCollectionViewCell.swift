//
//  PlayerCollectionViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/19/24.
//

import UIKit

final class PlayerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        let image = IconImage.circleX.image
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playerImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let playerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.label4_B
        return label
    }()
}
