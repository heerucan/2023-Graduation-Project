//
//  Image.swift
//  Kevin
//
//  Created by heerucan on 2023/04/30.
//

import UIKit

enum Image {
    static let retry = UIImage(named: "btn_retry")!
    static let negative = UIImage(named: "img_Pink")!
    static let neutral = UIImage(named: "img_Blue")!
    static let positive = UIImage(named: "img_Green")!
    static let back = UIImage(named: "btn_back")!
    static let setting = UIImage(named: "btn_setting")!
    
    enum Sticker {
        static let neutral = UIImage(named: "img_small_blue")!
        static let positive = UIImage(named: "img_small_green")!
        static let negative = UIImage(named: "img_small_pink")!
    }
    
    enum Back {
        static let green = UIImage(named: "img_greenBack")!
        static let blue = UIImage(named: "img_blueBack")!
        static let pink = UIImage(named: "img_pinkBack")!
    }
}
