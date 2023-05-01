//
//  Font.swift
//  Kevin
//
//  Created by heerucan on 2023/04/28.
//

import UIKit

enum KevinFontType {
    case black
    case semibold
    case medium
    case regular
}

extension UIFont {
    static func kevinFont(size: CGFloat, type: KevinFontType = .regular) -> UIFont {
        switch type {
        case .black:
            return .systemFont(ofSize: size, weight: .black)
        case .semibold:
            return .systemFont(ofSize: size, weight: .semibold)
        case .medium:
            return .systemFont(ofSize: size, weight: .medium)
        case .regular:
            return .systemFont(ofSize: size, weight: .regular)
        }
    }
}
