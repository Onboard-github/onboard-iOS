//
//  BaseButton.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/19.
//

import UIKit

enum ButtonStatus {
    case `default`
    case disabled
    case pressed
}

enum ButtonStyle {
    case normal
    case bottom
    case rounded
}

class BaseButton: UIButton {
    
    var status: ButtonStatus {
        didSet {
            self.setButton()
        }
    }
    
    private var style: ButtonStyle {
        didSet {
            self.setButton()
        }
    }
    
    private var bgColor: UIColor?
    private var typo: UIFont?
    private var textColor: UIColor?
    
    init(status: ButtonStatus, style: ButtonStyle) {
        self.status = status
        self.style = style
        
        super.init(frame: .zero)
        
        self.setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        switch status {
        case .default:
            self.bgColor = Colors.Orange_10
            self.textColor = Colors.Gray_2
            self.typo = Font.Typography.label3_B
            self.isEnabled = true
        case .disabled:
            self.bgColor = Colors.Gray_4
            self.textColor = Colors.Gray_7
            self.typo = Font.Typography.label3_M
            self.isEnabled = false
        case .pressed:
            self.bgColor = Colors.Gray_15
            self.textColor = Colors.Gray_1
            self.typo = Font.Typography.label3_B
            self.isEnabled = true
        }
        
        switch style {
        case .normal:
            break
        case .bottom:
            self.layer.cornerRadius = 8
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            self.clipsToBounds = true
        case .rounded:
            self.layer.cornerRadius = 8
            self.clipsToBounds = true
        }
        
        self.backgroundColor = self.bgColor
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = self.typo
    }
}
