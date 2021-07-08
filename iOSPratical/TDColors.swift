//
//  TDColors.swift
//  iOSPratical
//
//  Created by Eduardo Fornari on 13/05/21.
//

import UIKit

enum TDColors {
    case green
    case black
    case primary

    var valueColor: UIColor {
        switch self {
        case .green:
            return .systemGreen
        case .black:
            return .black
        case .primary:
            return UIColor(red: 0.20, green: 0.51, blue: 0.05, alpha: 1.00)
        }
    }
}
