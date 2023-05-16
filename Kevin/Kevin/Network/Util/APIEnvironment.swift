//
//  APIEnvironment.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

enum APIEnvironment {
    case base
    case naver
    case chat
    
    var url: URL {
        switch self {
        case .base:
            return URL(string: "http://54.180.123.11/")!
        case .naver:
            return URL(string: "https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/")!
        case .chat:
            return URL(string: "https://api.openai.com/v1/")!
        }
    }
}
