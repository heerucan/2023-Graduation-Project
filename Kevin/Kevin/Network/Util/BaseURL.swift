//
//  BaseURL.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

enum BaseURL {
    static let chat = URL(string: "https://api.openai.com/v1/")!
    static let naver = URL(string: "https://naveropenapi.apigw.ntruss.com/sentiment-analysis/v1/")!
    static let server = URL(string: "http://54.180.123.11/")!
}
