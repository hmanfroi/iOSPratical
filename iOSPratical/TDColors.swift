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

    var valueColor: UIColor {
        switch self {
        case .green:
            return .systemGreen
        case .black:
            return .black
        }
    }
}
