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
        
        setupDefaults()
        setupBorder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [Colors.Gray_2.cgColor, Colors.Gray_3.cgColor]
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupDefaults() {
        self.font = Font.Typography.body2_R
        self.borderStyle = .roundedRect
        self.keyboardType = .default
        self.tintColor = Colors.Orange_8
        self.backgroundColor = .clear
    }
    
    private func setupBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Colors.Gray_3.cgColor
    }
}
