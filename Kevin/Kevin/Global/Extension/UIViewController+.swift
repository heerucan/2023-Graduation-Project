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
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        if cancelButtonNeeded {
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alertViewController.addAction(cancelAction)
        }
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    func makeVibrate(degree: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: degree)
        generator.impactOccurred()
    }
}
