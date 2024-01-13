//
//  GameResultCollectionViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/12/24.
//

import UIKit

final class GameResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Metric
    
    private enum Metric {
        static let imageWidth: CGFloat = 102
        static let imageHeight: CGFloat = 132
        static let labelTopSpacing: CGFloat = 5
    }
    
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
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.backgroundColor = Colors.White
        
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.addSubview(self.gameImage)
        self.addSubview(self.gameLabel)
        
        self.gameImage.snp.makeConstraints {
            $0.width.equalTo(Metric.imageWidth)
            $0.height.equalTo(Metric.imageHeight)
        }
        
        self.gameLabel.snp.makeConstraints {
            $0.top.equalTo(gameImage.snp.bottom).offset(Metric.labelTopSpacing)
        }
    }
}
