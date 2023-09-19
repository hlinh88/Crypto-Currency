//
//  ColorExtension.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 13/9/2023.
//

import UIKit

extension UIColor {
    static let mainColor: UIColor = {
        return UIColor(red: 113/255, green: 93/255, blue: 255/255, alpha: 1.0)
    }()

    static let buttonColor: UIColor = {
        return UIColor(red: 44/255, green: 46/255, blue: 52/255, alpha: 1.0)
    }()

    static let chartBackgroundColor: UIColor = {
        return UIColor(red: 25/255, green: 28/255, blue: 33/255, alpha: 1.0)
    }()

    static let chartFillTop: UIColor = {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
    }()

    static let chartFillBottom: UIColor = {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
    }()

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3:
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha) / 255)
    }
}
