//
//  EmotionResponse.swift
//  Kevin
//
//  Created by heerucan on 2023/05/20.
//

import Foundation

// 배열
struct CalendarResponse: Codable {
    let emotionID: Int
    let recordDate, emotionType: String

    enum CodingKeys: String, CodingKey {
        case emotionID = "emotionId"
        case recordDate, emotionType
    }
}
