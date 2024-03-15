//
//  GroupListTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/15/24.
//

import UIKit

final class GroupListTableViewCell: UITableViewCell {
    
    // MARK: - Metric
    
    private enum Metric {
        static let labelLeading: CGFloat = 30
    }
    
    // MARK: - UI
    
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body2_R
        return label
    }()
    
    private let checkImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.check_duotone.image
        imageView.image = image
        return imageView
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        self.addSubview(self.groupNameLabel)
        self.addSubview(self.checkImage)
        
        self.groupNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.labelLeading)
            $0.centerY.equalToSuperview()
        }
        
        self.checkImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Metric.labelLeading)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureName(name: String) {
        self.groupNameLabel.text = name
    }
}
