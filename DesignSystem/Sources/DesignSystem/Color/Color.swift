//
//  Color.swift
//  
//
//  Created by Dinmukhamed on 11.09.2023.
//

import UIKit

public struct Color {
// background accent palette.blue.500
    public static let ratingOrange: UIColor = UIColor(hex: "#FFA800")
    
    public static let ratingBackgroundOrange: UIColor = UIColor(hex: "#FFC70033")
    
    public static let mainBlue: UIColor = UIColor(hex: "#0D72FF")
    
    public static let tagBackgroundGray: UIColor = UIColor(hex: "#FBFBFC")
    
    public static let tagBackgroundText: UIColor = UIColor(hex: "#828796")
    
}

extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexString).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexString.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // RGBA (32-bit)
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
