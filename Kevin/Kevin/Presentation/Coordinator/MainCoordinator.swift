//
//  MainCoordinator.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    weak var delegate: CoordinatorFinishDelegate?
    var childCoordinators = [Coordinator]()
    // 화면 전환을 위해 사용하는 UINavigationController 객체이다.
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MainCoordinator 객체의 작업을 시작하는 메소드
    // MainVC 객체를 만들고, UINavigationController에 추가하여 화면에 보여준다.
    func start() {
        let viewModel = MainViewModel(coordinator: self)
        let viewController = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // 특정 날짜를 인자로 받아 PostVC을 만들고 UINavigationController에 추가해서 화면에 보여준다.
    func showWriteScreen(forDate date: Date) {
        let viewModel = WriteViewModel(coordinator: self)
        let viewController = WriteViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetailScreen(for content: String) {
        let viewModel = DetailViewModel(coordinator: self)
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showAnalysisScreen(for content: String) {
        let viewModel = AnalysisViewModel(coordinator: self)
        let viewController = AnalysisViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popRootViewController(toastMessage: String?) {
        navigationController.popToRootViewController(animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
