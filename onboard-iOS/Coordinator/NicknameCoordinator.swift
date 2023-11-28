//
//  NicknameCoordinator.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import UIKit

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
