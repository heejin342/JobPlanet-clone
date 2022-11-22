//
//  TabButtonType.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import Foundation
import UIKit

enum TabButtonType: Int {
    case recruit = 0
    case company = 1
    
    func getTabName() -> String {
        switch self {
        case .recruit: return "채용"
        case .company: return "기업"
        }
    }    
}
