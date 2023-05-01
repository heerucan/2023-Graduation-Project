//
//  ViewModelType.swift
//  Kevin
//
//  Created by heerucan on 2023/04/27.
//

import UIKit

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

extension ViewModelType {
    func makeVibrate(degree: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
}
