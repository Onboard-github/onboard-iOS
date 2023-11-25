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

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showLoginViewController()
    }
    
    private func showLoginViewController() {
        let appleLoginManager = AppleLoginManagerImpl()
        let authRepository = AuthRepositoryImpl()
        let appleLoginUseCase = AppleLoginUseCaseImpl(
            appleLoginManager: appleLoginManager,
            authRepository: authRepository
        )
        
        let kakaoLoginManager = KakaoLoginManagerImpl()
        let kakaoLoginUseCase = KakaoLoginUseCaseImpl(
            kakaoLoginManager: kakaoLoginManager,
            authRepository: authRepository
        )
        let reactor = LoginReactor(
            appleUseCase: appleLoginUseCase,
            kakaoUseCase: kakaoLoginUseCase
        )
        let viewController = LoginViewController(reactor: reactor)
        
        self.navigationController?.viewControllers = [viewController]
    }
}
