//
//  PlayerCollectionViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/19/24.
//

import UIKit

final class PlayerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Metric
    
    private enum Metric {
        static let buttonMargin: CGFloat = 5
        static let buttonSize: CGFloat = 12
        static let imageSize: CGFloat = 32
        static let labelMargin: CGFloat = 2
    }
    
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
    
    // MARK: - Properties
    
    var didTapDeleteButton: (() -> Void)?
    
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
        
        self.addConfigure()
        self.makeConstraints()
    }
    
    private func addConfigure() {
        self.deleteButton.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapDeleteButton?()
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.contentView.addSubview(self.deleteButton)
        self.addSubview(self.playerImage)
        self.addSubview(self.playerLabel)
        
        self.deleteButton.snp.makeConstraints {
            $0.top.equalTo(Metric.buttonMargin)
            $0.trailing.equalTo(-Metric.buttonMargin)
            $0.width.height.equalTo(Metric.buttonSize)
        }
        
        self.playerImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(Metric.imageSize)
        }
        
        self.playerLabel.snp.makeConstraints {
            $0.top.equalTo(playerImage.snp.bottom).offset(Metric.labelMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.labelMargin)
        }
    }
    
    func configure(image: UIImage?, title: String) {
        self.playerImage.image = image
        self.playerLabel.text = title
    }
}
