//
//  DefaultAppCoordinator.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

final class AppCoordinator: Coordinator {
    // 현재 활성화된 코디네이터를 추적하는 데 사용하는 배열
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // 앱 시작 시 호출
    // 메인화면의 MainCoordinator 생성하고 start() 메서드 호출해서 메인화면으로 이동
    func start() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }

    // 환경 설정 화면으로 이동 - 해당 코디네이터를 childCoordinators 배열에 추가
    func showSettingScreen() {
        let settingsCoordinator = SettingCoordinator(navigationController: navigationController)
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.start()
    }
    
    // 자식 코디네이터가 종료될 때 호출, childCoordinators 배열에서 해당 코디네이터 삭제
    func childDidFinish(_ childCoordinator: Coordinator?) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return coordinator === childCoordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
