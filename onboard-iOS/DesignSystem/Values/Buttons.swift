//
//  Buttons.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/19.
//

import UIKit

struct Buttons {
    var defaultButton: UIButton
    var disabledButton: UIButton
    var pressedButton: UIButton
    
    var bottomDefaultButton: UIButton
    var bottomDisabledButton: UIButton
    var bottomPressedButton: UIButton

    init() {
        self.defaultButton = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Orange_10
            return button
        }()

        self.disabledButton = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_7, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_M
            button.backgroundColor = Colors.Gray_4
            return button
        }()

        self.pressedButton = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Gray_15
            return button
        }()
        
        self.bottomDefaultButton = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Orange_10
            return button
        }()

        self.bottomDisabledButton = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_7, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_M
            button.backgroundColor = Colors.Gray_4
            return button
        }()

        self.bottomPressedButton = {
            let button = UIButton(type: .custom)
            button.setTitleColor(Colors.Gray_1, for: .normal)
            button.titleLabel?.font = Font.Typography.label3_B
            button.backgroundColor = Colors.Gray_15
            return button
        }()
    }
}
