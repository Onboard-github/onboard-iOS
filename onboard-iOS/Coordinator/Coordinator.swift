//
//  Coordinator.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/25/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        DispatchQueue.main.async {
            self.showLoginViewController()
        }
    }
    
    private func showLoginViewController() {
        let coordinator = LoginCoordinator(
            navigationController: self.navigationController
        )
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
