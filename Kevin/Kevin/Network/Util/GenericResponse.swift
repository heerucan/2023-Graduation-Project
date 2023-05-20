//
//  GenericResponse.swift
//  Kevin
//
//  Created by heerucan on 2023/05/20.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? values.decode(Int.self, forKey: .code)) ?? 0
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
