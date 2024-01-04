//
//  Colors.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/05.
//

import UIKit

enum Colors {
    
    // Gray Scale
    static let Gray_15 = UIColor(hex: "#171717")
    static let Gray_14 = UIColor(hex: "#242424")
    static let Gray_13 = UIColor(hex: "#333333")
    static let Gray_12 = UIColor(hex: "#3D3D3D")
    static let Gray_11 = UIColor(hex: "#555555")
    static let Gray_10 = UIColor(hex: "#6F6F6F")
    static let Gray_9 = UIColor(hex: "#8B8B8B")
    static let Gray_8 = UIColor(hex: "#A5A5A5")
    static let Gray_7 = UIColor(hex: "#C1C1C1")
    static let Gray_6 = UIColor(hex: "#DFDFDF")
    static let Gray_5 = UIColor(hex: "#ECECEC")
    static let Gray_4 = UIColor(hex: "#EFEFEF")
    static let Gray_3 = UIColor(hex: "#F5F4F3")
    static let Gray_2 = UIColor(hex: "#F7F7F7")
    static let Gray_1 = UIColor(hex: "#FBFBFB")
    
    // Orange Scale
    static let Orange_10 = UIColor(hex: "#FF4D0D")
    static let Orange_9 = UIColor(hex: "#FF5F25")
    static let Orange_8 = UIColor(hex: "#FF713D")
    static let Orange_7 = UIColor(hex: "#FF8256")
    static let Orange_6 = UIColor(hex: "#FF946E")
    static let Orange_5 = UIColor(hex: "#FFA686")
    static let Orange_4 = UIColor(hex: "#FFB89E")
    static let Orange_3 = UIColor(hex: "#FFCAB6")
    static let Orange_2 = UIColor(hex: "#FFDBCF")
    static let Orange_1 = UIColor(hex: "#FFEDE7")
    
    // Red
    static let Red = UIColor(hex: "#F11414")
    
    // Yellow
    static let Yellow = UIColor(hex: "#FFBC10")
    
    // White
    static let White = UIColor(hex: "#FFFFFF")
    
    // Black
    static let Black = UIColor(hex: "#000000")
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
