//
//  EmotionAPI.swift
//  Kevin
//
//  Created by heerucan on 2023/05/20.
//

import Foundation

import Moya

enum EmotionAPI {
    case all(date: String)
    case detail(emotionId: Int)
    case write(EmotionRequest)
}

extension EmotionAPI: TargetType {
    var baseURL: URL {
        return APIEnvironment.base.url
    }
    
    var path: String {
        switch self {
        case .all, .write:
            return "emotion"
        case let .detail(emotionId):
            return "emotion/\(emotionId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .all, .detail:
            return .get
        case .write:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .all(date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        case .detail:
            return .requestPlain
        case let .write(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
