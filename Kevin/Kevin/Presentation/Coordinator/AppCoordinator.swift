//
//  AppCoordinator.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

final class AppCoordinator: AppCoordinatorProtocol {
    
    weak var delegate: CoordinatorFinishDelegate? = nil
    
    // 현재 활성화된 코디네이터를 추적하는 데 사용하는 배열
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // 앱 시작 시 호출 - 메인화면의 MainCoordinator 생성하고 start() 메서드 호출해서 메인화면으로 이동
    func start() {
        showMainFlow()
    }
    
    func showMainFlow() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.delegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }
    
    func showSettingFlow() {
        let settingCoordinator = SettingCoordinator(navigationController: navigationController)
        settingCoordinator.delegate = self
        settingCoordinator.start()
        childCoordinators.append(settingCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func didFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return coordinator === childCoordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
