//
//  GroupSearchCoordinator.swift
//  onboard-iOS
//
//  Created by 윤다예 on 12/2/23.
//

import UIKit

final class GroupSearchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repository = GroupRepositoryImpl()
        let useCase = GroupSearchUseCaseImpl(groupRepository: repository)
        let reactor = GroupSearchReactor(useCase: useCase)
        let viewController = GroupSearchViewController(reactor: reactor)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
