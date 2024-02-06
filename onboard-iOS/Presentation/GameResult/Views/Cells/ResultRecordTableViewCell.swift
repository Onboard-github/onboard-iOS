//
//  ResultRecordTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/3/24.
//

import UIKit

final class ResultRecordTableViewCell: UITableViewCell {
    
    // MARK: - Metric
    
    private enum Metric {
        static let rankingLeading: CGFloat = 20
        static let rankLeading: CGFloat = 2
        static let imageLeading: CGFloat = 15
        static let titleLeading: CGFloat = 12
        static let resultTrailing: CGFloat = 7
        static let scroeTrailing: CGFloat = 20
    }
    
    // MARK: - UI
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Typography.title2
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_13
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let titleImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        self.addSubview(self.rankingLabel)
        self.addSubview(self.rankLabel)
        self.addSubview(self.titleImage)
        self.addSubview(self.titleLabel)
        self.addSubview(self.resultLabel)
        self.addSubview(self.scoreLabel)
        
        self.rankingLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Metric.rankingLeading)
            $0.centerY.equalToSuperview()
        }
        
        self.rankLabel.snp.makeConstraints {
            $0.leading.equalTo(rankingLabel.snp.trailing).offset(Metric.rankLeading)
            $0.centerY.equalToSuperview()
        }
        
        self.titleImage.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(Metric.imageLeading)
            $0.centerY.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleImage.snp.trailing).offset(Metric.titleLeading)
            $0.centerY.equalToSuperview()
        }
        
        self.resultLabel.snp.makeConstraints {
            $0.trailing.equalTo(scoreLabel.snp.leading).offset(-Metric.resultTrailing)
            $0.centerY.equalToSuperview()
        }
        
        self.scoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Metric.scroeTrailing)
            $0.centerY.equalToSuperview()
        }
    }
    
    internal func configure(
        ranking: String,
        rank: String,
        image: UIImage,
        nickname: String,
        result: String,
        score: String
    ) {
        self.rankingLabel.text = ranking
        self.rankLabel.text = rank
        self.titleImage.image = image
        self.titleLabel.text = nickname
        self.resultLabel.text = result
        self.scoreLabel.text = score
        
        self.rankingLabel.textColor = (ranking == "1") ? Colors.Orange_10 : Colors.Gray_14
    }
}
