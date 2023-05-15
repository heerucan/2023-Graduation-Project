//
//  UIViewController+.swift
//  Kevin
//
//  Created by heerucan on 2023/04/28.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String = "알림",
                   message: String,
                   cancelButtonNeeded: Bool = false,
                   okAction: ((UIAlertAction) -> Void)? = nil,
                   completion: (() -> Void)? = nil
    ) {
        makeVibrate()
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: StringLiteral.Button.ok, style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        if cancelButtonNeeded {
            let cancelAction = UIAlertAction(title: StringLiteral.Button.cancel, style: .cancel, handler: nil)
            alertViewController.addAction(cancelAction)
        }
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    func makeVibrate(degree: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
    
    func hideKeyboardTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
