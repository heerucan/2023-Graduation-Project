//
//  AnalysisType.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

@frozen
enum AnalysisType: String {
    case positive = "positive"
    case negative = "negative"
    case neutral = "neutral"
    
    var color: UIColor {
        switch self {
        case .positive:
            return .green200
        case .negative:
            return .pink200
        case .neutral:
            return .blue200
        }
    }
    
    var sticker: UIImage! {
        switch self {
        case .positive:
            return Image.positive
        case .negative:
            return Image.negative
        case .neutral:
            return Image.neutral
        }
    }
    
    var smallSticker: UIImage? {
        switch self {
        case .positive:
            return Image.Sticker.positive
        case .negative:
            return Image.Sticker.negative
        case .neutral:
            return Image.Sticker.neutral
        }
    }
    
    var back: UIImage? {
        switch self {
        case .positive:
            return Image.Back.green
        case .negative:
            return Image.Back.pink
        case .neutral:
            return Image.Back.blue
        }
    }
}
