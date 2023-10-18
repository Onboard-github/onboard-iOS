//
//  TextField.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/14.
//

import UIKit

class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setColors()
        setupDefaults()
        setupBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setColors() {
        self.tintColor = Colors.Orange_8
        self.backgroundColor = Colors.Gray_2
    }
    
    private func setupDefaults() {
        self.font = Font.Typography.body2_R
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 12
        self.keyboardType = .default
    }
    
    private func setupBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Colors.Gray_3.cgColor
    }
}
