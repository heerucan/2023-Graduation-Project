//
//  GenericResponse.swift
//  Kevin
//
//  Created by heerucan on 2023/05/20.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    let code: Int
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}

struct VoidData: Decodable { }
