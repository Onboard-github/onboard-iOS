//
//  NicknameCoordinator.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import UIKit

protocol NicknameCoordinatorNavigateDelegate: AnyObject {
    func showGroupSearch()
}

final class NicknameCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reactor = NicknameReactor(coordinator: self)
        let viewController = NicknameViewController(reactor: reactor)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension NicknameCoordinator: NicknameCoordinatorNavigateDelegate {
    func showGroupSearch() {
        let coordinator = GroupSearchCoordinator(
            navigationController: self.navigationController
        )
        coordinator.start()
    }
}
