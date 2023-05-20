//
//  EmotionRequest.swift
//  Kevin
//
//  Created by heerucan on 2023/05/20.
//

import Foundation

struct EmotionRequest: Codable {
    let recordDate: String
    let emotionContent: String
    let positive: CGFloat
    let negative: CGFloat
    let neutral: CGFloat
    let analysis: String
    let emotionType: String
}
