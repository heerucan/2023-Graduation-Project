//
//  NSObject+.swift
//  Kevin
//
//  Created by heerucan on 2023/04/28.
//

import Foundation

extension NSObject {
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
     var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
