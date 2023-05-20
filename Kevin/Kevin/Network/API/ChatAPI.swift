//
//  ChatAPI.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import Moya

enum ChatAPI {
    case chat(request: ChatRequestDTO)
}

extension ChatAPI: TargetType {
    var baseURL: URL {
        return APIEnvironment.chat.url
    }
    
    var path: String {
        switch self {
        case .chat:
            return "chat/completions"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case let .chat(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Authorization": "Bearer \(APIKey.chatKey.rawValue)"
        ]
    }
}
