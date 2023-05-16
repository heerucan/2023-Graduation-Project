//
//  ChatRequestDTO.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

struct ChatRequestDTO: Codable {
    var model: String
    var messages: [MessagesDTO]
    
    func toDomain() -> ChatRequest {
        let domainMessages = messages.map { $0.toDomain() }
        return ChatRequest.init(model: model, messages: domainMessages)
    }
}

struct MessagesDTO: Codable {
    let role: String
    let content: String
    
    func toDomain() -> Messages {
        return Messages(role: role, content: content)
    }
}
