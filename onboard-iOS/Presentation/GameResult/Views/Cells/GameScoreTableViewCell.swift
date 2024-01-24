//
//  GameScoreTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/25/24.
//

import UIKit

final class GameScoreTableViewCell: UITableViewCell {
    
    // MARK: - Metric
    
    private enum Metric {
        static let leftRightMargin: CGFloat = 10
        static let playerLeftSpacing: CGFloat = 90
        static let textFieldBottomSpacing: CGFloat = 1
        static let textFieldWidth: CGFloat = 100
        static let textFieldRightSpacing: CGFloat = 3
        static let underLineTopSpacing: CGFloat = 5
        static let underLineHeight: CGFloat = 1
    }

    // MARK: - UI
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.title4
        return label
    }()
    
    private let diceImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.dice.image
        imageView.image = image
        return imageView
    }()
    
    private let playerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title3
        return label
    }()
    
    private lazy var scoreTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = Colors.Gray_15
        textField.font = Font.Typography.headLine
        textField.tintColor = Colors.Orange_8
        textField.keyboardType = .numberPad
        textField.textAlignment = .right
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.headLine as Any,
            .foregroundColor: Colors.Gray_6]
        textField.attributedPlaceholder = NSAttributedString(string: TextLabels.game_record_placeholder,
                                                             attributes: attributes)
        return textField
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.game_record_score
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title4
        return label
    }()
    
    private let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_6
        return view
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
        self.contentView.addSubview(self.rankLabel)
        self.contentView.addSubview(self.diceImage)
        self.contentView.addSubview(self.playerLabel)
        self.contentView.addSubview(self.scoreTextField)
        self.contentView.addSubview(self.scoreLabel)
        self.contentView.addSubview(self.underLine)
        
        self.rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.diceImage.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(Metric.leftRightMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.playerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.playerLeftSpacing)
            $0.centerY.equalToSuperview()
        }
        
        self.scoreTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(underLine.snp.top).inset(Metric.textFieldBottomSpacing)
            $0.width.equalTo(Metric.textFieldWidth)
            $0.trailing.equalTo(scoreLabel.snp.leading).offset(-Metric.textFieldRightSpacing)
        }
        
        self.scoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.underLine.snp.makeConstraints {
            $0.top.equalTo(playerLabel.snp.bottom).offset(Metric.underLineTopSpacing)
            $0.leading.equalTo(playerLabel.snp.leading)
            $0.trailing.equalTo(scoreLabel.snp.trailing)
            $0.height.equalTo(Metric.underLineHeight)
        }
    }
}
