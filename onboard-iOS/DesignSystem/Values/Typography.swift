//
//  Typography.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/06.
//

import UIKit

enum Font: String {
    case bold = "SpoqaHanSansNeo-Bold"
    case medium = "SpoqaHanSansNeo-Medium"
    case regular = "SpoqaHanSansNeo-Regular"
    case light = "SpoqaHanSansNeo-Light"
}

struct Typography {
    
    static func setFont(font: Font, fontSize: CGFloat) -> UIFont? {
        return UIFont(name: font.rawValue, size: fontSize)
    }
    
    // HeadLine
    static let headLine = setFont(font: .bold, fontSize: 28)
    
    // Title
    static let title1 = setFont(font: .bold, fontSize: 20)
    static let title2 = setFont(font: .bold, fontSize: 18)
    static let title3 = setFont(font: .bold, fontSize: 16)
    static let title4 = setFont(font: .bold, fontSize: 14)
    static let title5 = setFont(font: .bold, fontSize: 13)
    
    // Body
    static let body1_M = setFont(font: .medium, fontSize: 26)
    static let body1_R = setFont(font: .regular, fontSize: 26)
    
    static let body2_M = setFont(font: .medium, fontSize: 24)
    static let body2_R = setFont(font: .regular, fontSize: 24)
    
    static let body3_M = setFont(font: .medium, fontSize: 14)
    static let body3_R = setFont(font: .regular, fontSize: 14)
    
    static let body4_M = setFont(font: .medium, fontSize: 12)
    static let body4_R = setFont(font: .regular, fontSize: 12)
    
    static let body5_M = setFont(font: .medium, fontSize: 11)
    static let body5_R = setFont(font: .regular, fontSize: 11)
    
    static let body6_R = setFont(font: .regular, fontSize: 10)
    
    // Label
    static let label1_B = setFont(font: .bold, fontSize: 18)
    static let label1_M = setFont(font: .medium, fontSize: 18)
    
    static let label2_B = setFont(font: .bold, fontSize: 16)
    static let label2_M = setFont(font: .medium, fontSize: 16)
    
    static let label3_B = setFont(font: .bold, fontSize: 14)
    static let label3_M = setFont(font: .medium, fontSize: 14)
    
    static let label4_B = setFont(font: .bold, fontSize: 12)
    static let label4_M = setFont(font: .medium, fontSize: 12)
}
