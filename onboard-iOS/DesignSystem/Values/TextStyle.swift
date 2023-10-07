//
//  TextStyle.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/08.
//

import UIKit

struct TextStyle {
    
    // HeadLine
    static let headLine: CGFloat = 36.0
    
    // Title
    static let title1: CGFloat = 28.0
    static let title2: CGFloat = 26.0
    static let title3: CGFloat = 24.0
    static let title4: CGFloat = 22.0
    static let title5: CGFloat = 20.0
    
    // Body
    static let body1_M: CGFloat = 26.0
    static let body1_R: CGFloat = 26.0
    
    static let body2_M: CGFloat = 24.0
    static let body2_R: CGFloat = 24.0
    
    static let body3_M: CGFloat = 20.0
    static let body3_R: CGFloat = 20.0
    
    static let body4_M: CGFloat = 16.0
    static let body4_R: CGFloat = 16.0
    
    static let body5_M: CGFloat = 14.0
    static let body5_R: CGFloat = 14.0
    
    static let body6_R: CGFloat = 14.0
    
    // Label
    static let label1_B: CGFloat = 24.0
    static let label1_M: CGFloat = 24.0
    
    static let label2_B: CGFloat = 22.0
    static let label2_M: CGFloat = 22.0
    
    static let label3_B: CGFloat = 20.0
    static let label3_M: CGFloat = 20.0
    
    static let label4_B: CGFloat = 16.0
    static let label4_M: CGFloat = 16.0
}

extension UILabel {
    func setAttributed(lineHeight: CGFloat? = nil, text: String) {
        
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()

        if let lineHeight = lineHeight {
            paragraphStyle.maximumLineHeight = lineHeight
            paragraphStyle.minimumLineHeight = lineHeight
            
            attributedString.addAttribute(
                .baselineOffset,
                value: (lineHeight - self.font.lineHeight) / 4,
                range: NSRange(location: 0, length: attributedString.length)
            )
        }
        
        let letterSpacing: CGFloat = -0.4
        attributedString.addAttribute(
            .kern,
            value: letterSpacing,
            range: NSRange(location: 0, length: attributedString.length)
        )

        self.attributedText = attributedString
    }
}
