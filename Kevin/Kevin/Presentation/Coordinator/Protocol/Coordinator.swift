//
//  Coordinator.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

protocol Coordinator: AnyObject {
    var delegate: CoordinatorFinishDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        delegate?.didFinish(self)
    }
}
