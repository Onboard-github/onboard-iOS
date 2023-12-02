//
//  LoginCoordinator.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/25/23.
//

import UIKit

protocol LoginCoordinatorNavigateDelegate: AnyObject {
    func showTermsAgreementView()
}

final class LoginCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let appleLoginManager = AppleLoginManagerImpl()
        let authRepository = AuthRepositoryImpl()
        let keychainService = KeychainServiceImpl()
        let appleLoginUseCase = AppleLoginUseCaseImpl(
            appleLoginManager: appleLoginManager,
            authRepository: authRepository,
            keychainService: keychainService
        )
        
        let kakaoLoginManager = KakaoLoginManagerImpl()
        let kakaoLoginUseCase = KakaoLoginUseCaseImpl(
            kakaoLoginManager: kakaoLoginManager,
            authRepository: authRepository
        )
        let reactor = LoginReactor(
            appleUseCase: appleLoginUseCase,
            kakaoUseCase: kakaoLoginUseCase,
            coordinator: self
        )
        let viewController = LoginViewController(reactor: reactor)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension LoginCoordinator: LoginCoordinatorNavigateDelegate {
    
    func showTermsAgreementView() {
        let coordinator = TermsAgreementCoordinator(
            navigationController: self.navigationController
        )
        coordinator.start()
    }
    
    func showNicknameSetting() {
        let coordinator = NicknameCoordinator(
            navigationController: self.navigationController
        )
        coordinator.start()
    }
}
