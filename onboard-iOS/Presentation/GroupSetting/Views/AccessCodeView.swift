//
//  AccessCodeView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class AccessCodeView: UIView {
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_current
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_code
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title3
        return label
    }()
    
    private let newTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_new
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let requiredImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.requiredInput
        imageView.image = image.image
        return imageView
    }()
    
    private lazy var textField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body3_R
        text.layer.borderColor = Colors.Gray_7.cgColor
        text.backgroundColor = Colors.White
        text.keyboardType = .default
        return text
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_subTitle
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.access_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
}
