//
//  ChatRequestDTO.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

struct ChatRequestDTO: Codable {
    var model: String
    var messages: [Messages]
}

struct Messages: Codable {
    let role: String
    let content: String
    
    func toDomain() -> Messages {
        return Messages(role: role, content: content)
    }
}
