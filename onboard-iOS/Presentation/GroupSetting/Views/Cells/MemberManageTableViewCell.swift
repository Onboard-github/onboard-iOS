//
//  MemberManageTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class MemberManageTableViewCell: UITableViewCell {
    
    // MARK: - Metric
    
    private enum Metric {
        static let leftMargin: CGFloat = 24
        static let labelLeftSpacing: CGFloat = 14
        static let buttonRightMargin: CGFloat = 24
    }
    
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
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLabels.member_delete, for: .normal)
        button.setTitleColor(Colors.Orange_10, for: .normal)
        button.titleLabel?.font = Font.Typography.body5_R
        return button
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
        self.selectionStyle = .none
        
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleImage)
        self.addSubview(self.titleLabel)
        self.addSubview(self.deleteButton)
        
        self.titleImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.leftMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleImage.snp.trailing).offset(Metric.labelLeftSpacing)
            $0.centerY.equalToSuperview()
        }
        
        self.deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Metric.buttonRightMargin)
            $0.centerY.equalToSuperview()
        }
    }
}
