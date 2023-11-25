//
//  TermsAgreementCoordinator.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/25/23.
//

import UIKit

final class TermsAgreementCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reactor = TermsAgreementReactor()
        let viewController = TermsAgreementViewController(reactor: reactor)
        
        self.navigationController?.viewControllers = [viewController]
    }
}
