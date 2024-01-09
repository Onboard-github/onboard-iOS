//
//  AlertView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class AlertView: UIView {
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.White
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_13
        label.font = Font.Typography.body3_R
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.Orange_10, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_B
        button.backgroundColor = Colors.Gray_2
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.Gray_1, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_B
        button.backgroundColor = Colors.Orange_10
        return button
    }()
}
