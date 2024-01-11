//
//  GameResultCollectionViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/12/24.
//

import UIKit

final class GameResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private let gameImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let gameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body4_R
        label.textAlignment = .left
        return label
    }()
}
