//
//  ChatRequest.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

struct ChatRequest: Equatable {
    var model: String
    var messages: [Messages]
}

struct Messages: Equatable {
    let role: String
    let content: String
}
