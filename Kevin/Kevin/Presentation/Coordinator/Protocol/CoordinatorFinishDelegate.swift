//
//  CoordinatorFinishDelegate.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func didFinish(_ childCoordinator: Coordinator)
}
