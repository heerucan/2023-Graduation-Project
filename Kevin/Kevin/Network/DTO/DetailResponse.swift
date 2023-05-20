//
//  DetailResponse.swift
//  Kevin
//
//  Created by heerucan on 2023/05/20.
//

import Foundation

// 배열아님
struct DetailResponse: Codable {
    let recordDate, emotionContent: String
    let positive, negative, neutral: Int
    let analysis, emotionType: String
}
