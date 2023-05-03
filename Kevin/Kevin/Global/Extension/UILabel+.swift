//
//  UILabel+.swift
//  Kevin
//
//  Created by heerucan on 2023/04/28.
//

import UIKit

extension UILabel {
    func setCharacterSpacing(kernValue: CGFloat = -0.5) {
        guard let labelText = text else { return }
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: kernValue,
                                      range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func setLineSpacing(value: CGFloat = 7) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = value
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSMakeRange(0, attributedString.length))
            attributedText = attributedString
            lineBreakStrategy = .hangulWordPriority
        }
    }
}
