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
    let positive: Int
    let negative: Int
    let neutral: Int
    let analysis: String
    let emotionType: String
}
