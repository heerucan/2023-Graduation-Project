//
//  Coordinator.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func childDidFinish(_ childCoordinator: Coordinator)
}
