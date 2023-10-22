//
//  Button.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/19.
//

import UIKit

struct Button {
    var `default`: UIButton
    var disabled: UIButton
    var pressed: UIButton
    
    var bottomDefault: UIButton
    var bottomDisabled: UIButton
    var bottomPressed: UIButton

    init() {
        self.default = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Orange_10
            return button
        }()

        self.disabled = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_7, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_M
            button.backgroundColor = Colors.Gray_4
            return button
        }()

        self.pressed = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Gray_15
            return button
        }()
        
        self.bottomDefault = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Orange_10
            return button
        }()

        self.bottomDisabled = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_7, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_M
            button.backgroundColor = Colors.Gray_4
            return button
        }()

        self.bottomPressed = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Gray_15
            return button
        }()
    }
}
