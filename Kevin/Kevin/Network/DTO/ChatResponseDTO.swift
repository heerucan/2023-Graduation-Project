//
//  ChatResponseDTO.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import UIKit

struct ChatResponseDTO: Decodable {
    var id: String
    var object: String
    var created: Int
    var choices: [TextCompletionChoice]
    
    var resultText: String {
        choices.map(\.message.content).joined(separator: "\n")
    }
}

struct TextCompletionChoice: Decodable {
    var index: Int
    var message: Messages
    var finish_reason: String
}
