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
    
    private var status: ButtonStatus
    private var style: ButtonStyle {
        didSet {
            self.setButton(status: self.status,
                           style: self.style)
        }
    }
    
    private var bgColor: UIColor?
    private var typo: UIFont?
    private var textColor: UIColor?
    
    init(status: ButtonStatus, style: ButtonStyle) {
        self.status = status
        self.style = style
        
        super.init(frame: .zero)
        
        self.setButton(status: status, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton(status: ButtonStatus, style: ButtonStyle) {
        
        switch status {
        case .default:
            self.bgColor = Colors.Orange_5
            self.textColor = Colors.Gray_2
            self.typo = Font.Typography.label3_B
        case .disabled:
            self.bgColor = Colors.Gray_4
            self.textColor = Colors.Gray_7
            self.typo = Font.Typography.label3_M
        case .pressed:
            self.bgColor = Colors.Gray_15
            self.textColor = Colors.Gray_1
            self.typo = Font.Typography.label3_B
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
