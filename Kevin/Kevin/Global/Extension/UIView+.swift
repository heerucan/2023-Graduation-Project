//
//  UIView+.swift
//  Kevin
//
//  Created by heerucan on 2023/04/28.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func makeVibrate(degree: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
    
    func makeCorner(
        width: CGFloat = 3,
        color: CGColor? = nil,
        radius: CGFloat = 19
    ) {
        layer.borderWidth = width
        layer.borderColor = color
        layer.cornerRadius = radius
    }
}
