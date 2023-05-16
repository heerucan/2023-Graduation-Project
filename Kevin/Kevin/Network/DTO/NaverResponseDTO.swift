//
//  NaverResponseDTO.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

struct NaverResponseDTO: Codable {
    let document: Document
}

struct Document: Codable {
    let sentiment: String
    let confidence: Confidence
}

struct Confidence: Codable {
    let neutral, positive, negative: Double
}
