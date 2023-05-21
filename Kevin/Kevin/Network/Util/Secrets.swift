//
//  Secrets.swift
//  Kevin
//
//  Created by heerucan on 2023/05/21.
//

import Foundation

struct Secrets {
    private static func secrets() -> [String: Any] {
        let fileName = "Secrets"
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try! JSONSerialization.jsonObject(with: data) as! [String: Any]
    }

    static var naverKey: String {
        return secrets()["NAVER_KEY"] as! String
    }

    static var naverKeyID: String {
        return secrets()["NAVER_KEY_ID"] as! String
    }
    
    static var chatKey: String {
        return secrets()["CHAT_KEY"] as! String
    }
}
