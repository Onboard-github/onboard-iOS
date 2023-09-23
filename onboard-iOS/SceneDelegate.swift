//
//  SceneDelegate.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = scene

        let testUseCase = TestUseCaseImpl(repository: TestRepositoryImpl())
        let testReactor = TestReactor(
            useCase: testUseCase, appleUseCase: AppleLoginUseCaseImpl(appleLoginManager: AppleLoginManagerImpl()))
        let testViewController = TestViewController(reactor: testReactor)

        self.window?.rootViewController = testViewController
        
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}

