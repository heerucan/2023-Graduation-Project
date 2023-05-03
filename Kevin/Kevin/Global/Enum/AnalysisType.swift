//
//  AnalysisType.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

@frozen
enum AnalysisType: String {
    case positive = "긍정"
    case negative = "부정"
    case neutral = "중립"
    
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
    
    var sticker: UIImage? {
        switch self {
        case .positive:
            return Image.green
        case .negative:
            return Image.pink
        case .neutral:
            return Image.blue
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
