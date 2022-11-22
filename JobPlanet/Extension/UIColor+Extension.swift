//
//  UIColor+Extension.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/19.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Double = 1.0) {
        assert(0 <= red && red <= 255)
        assert(0 <= green && green <= 255)
        assert(0 <= blue && blue <= 255)

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    convenience init(rgb: Int, alpha: Double = 1.0) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha)
    }
}

extension UIColor {
    enum JobPlanet {
        static let green = UIColor(named: "green")!
        static let gray1 = UIColor(named: "gray1")!
        static let gray2 = UIColor(named: "gray2")!
        static let gray3 = UIColor(named: "gray3")!
    }
}
