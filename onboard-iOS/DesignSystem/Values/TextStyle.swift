//
//  TextStyle.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/08.
//

import UIKit

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
