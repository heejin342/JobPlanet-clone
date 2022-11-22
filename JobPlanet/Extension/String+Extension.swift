//
//  String+Extension.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/21.
//

import Foundation

extension String {
    var makeComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let price = Double(self)!
        return numberFormatter.string(from: NSNumber(value:price))!
    }
}
