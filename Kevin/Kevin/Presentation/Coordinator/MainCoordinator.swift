//
//  MainCoordinator.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

enum CoordinatorType {
    case main
    case setting
}

final class MainCoordinator: Coordinator {
    
    weak var delegate: CoordinatorFinishDelegate?
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .main
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showWriteScreen(date: Date, type: NavigationType) {
        let viewModel = WriteViewModel(coordinator: self, date: date, type: type)
        let viewController = WriteViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetailScreen(data: DetailResponse, type: NavigationType) {
        let viewModel = DetailViewModel(coordinator: self, data: data, type: type)
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showAnalysisScreen(data: ResultModel) {
        let viewModel = AnalysisViewModel(coordinator: self, data: data)
        let viewController = AnalysisViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showSettingFlow() {
        let settingCoordinator = SettingCoordinator(navigationController: navigationController)
        settingCoordinator.delegate = self
        settingCoordinator.start()
        childCoordinators.append(settingCoordinator)
    }
    
    func popRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: StringLiteral.Button.cancel, style: .default) { _ in
            self.navigationController.dismiss(animated: true)
        }
        let ok = UIAlertAction(title: StringLiteral.Button.ok, style: .destructive) { _ in
            self.finish()
        }
        alertViewController.addAction(cancel)
        alertViewController.addAction(ok)
        navigationController.present(alertViewController, animated: true)
    }
    
    func finish() {
        self.didFinish(self)
    }
}

extension MainCoordinator: CoordinatorFinishDelegate {
    func didFinish(_ childCoordinator: Coordinator) {
        navigationController.popViewController(animated: true)
    }
    
    func settingCoordinatorDidFinish() {
        self.start()
    }
}
