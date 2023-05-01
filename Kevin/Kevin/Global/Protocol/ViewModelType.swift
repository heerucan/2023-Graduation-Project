//
//  ViewModelType.swift
//  Kevin
//
//  Created by heerucan on 2023/04/27.
//

import Foundation

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
