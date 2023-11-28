//
//  TermsAgreementCoordinator.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/25/23.
//

import UIKit

protocol TermsAgreementCoordinatorNavigateDelegate: AnyObject {
    func showNicknameSetting()
}

final class TermsAgreementCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reactor = TermsAgreementReactor(coordinator: self)
        let viewController = TermsAgreementViewController(reactor: reactor)
        viewController.modalPresentationStyle = .overFullScreen
        
        self.navigationController?.present(viewController, animated: false)
    }
    
    func showTerms(url: String) {
        let reactor = TermsReactor(url: url)
        let viewController = TermsViewController(reactor: reactor)
        
        self.navigationController?.dismiss(animated: true)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TermsAgreementCoordinator: TermsAgreementCoordinatorNavigateDelegate {
    
    func showNicknameSetting() {
        let coordinator = NicknameCoordinator(
            navigationController: self.navigationController
        )
        self.navigationController?.dismiss(animated: true)
        coordinator.start()
    }
}
