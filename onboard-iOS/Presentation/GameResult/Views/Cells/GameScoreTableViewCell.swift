//
//  GameScoreTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/25/24.
//

import UIKit

final class GameScoreTableViewCell: UITableViewCell {
    
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
}
