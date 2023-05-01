//
//  SettingCoordinator.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

final class SettingCoordinator: Coordinator {
    
    weak var delegate: CoordinatorFinishDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SettingViewModel(coordinator: self)
        let viewController = SettingViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinishSetting() {
        parentCoordinator?.finish()
    }
}
