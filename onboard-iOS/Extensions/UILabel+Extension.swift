//
//  UILabel+Extension.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/28.
//

import UIKit

extension UILabel {

    func setAttributed(
        lineHeight: CGFloat? = nil,
        letterSpacing: CGFloat? = nil,
        text: String
    ) {

        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()

        if let lineHeight {
            paragraphStyle.maximumLineHeight = lineHeight
            paragraphStyle.minimumLineHeight = lineHeight

            attributedString.addAttribute(
                .baselineOffset,
                value: (lineHeight - self.font.lineHeight) / 4,
                range: NSRange(location: 0, length: attributedString.length)
            )
        }

        if let letterSpacing {
            attributedString.addAttribute(
                .kern,
                value: letterSpacing,
                range: NSRange(location: 0, length: attributedString.length)
            )
        }

        self.attributedText = attributedString
    }
}
