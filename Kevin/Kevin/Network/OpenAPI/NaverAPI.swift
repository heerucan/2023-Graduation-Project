//
//  NaverAPI.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import Moya

enum NaverAPI {
    case analyze(text: NaverRequestDTO)
}

extension NaverAPI: TargetType {
    var baseURL: URL {
        return BaseURL.naver
    }
    
    var path: String {
        switch self {
        case .analyze:
            return "analyze"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case let .analyze(text):
            return .requestJSONEncodable(text)
        }
    }
    
    var headers: [String: String]? {
        return [
            "X-NCP-APIGW-API-KEY-ID": APIKey.naverKeyId,
            "X-NCP-APIGW-API-KEY": APIKey.naverKey
        ]
    }
}
