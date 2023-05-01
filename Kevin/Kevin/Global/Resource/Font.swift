//
//  Font.swift
//  Kevin
//
//  Created by heerucan on 2023/04/28.
//

import UIKit

enum KevinFontType {
    case medium22
    case medium18
    case black16
    case medium16
    case regular16
    case semibold15
    case medium14
    case regular13
    case medium12
    
    var size: CGFloat {
        switch self {
        case .medium22:
            return 22
        case .medium18:
            return 18
        case .black16, .medium16, .regular16:
            return 16
        case .semibold15:
            return 15
        case .medium14:
            return 14
        case .regular13:
            return 13
        case .medium12:
            return 12
        }
    }
    
    var weight: UIFont.Weight {
        switch self {
        case .medium22, .medium18, .medium16, .medium14, .medium12:
            return .semibold
        case .black16:
            return .black
        case .regular16, .regular13:
            return .regular
        case .semibold15:
            return .semibold
        }
    }
}

extension UIFont {
    static func kevinFont(type: KevinFontType) -> UIFont {
        return .systemFont(ofSize: type.size, weight: type.weight)
    }
}
