//
//  SceneDelegate.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import GoogleSignIn

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
        
        self.initKakaoSDK()

        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        
        let coordinator = AppCoordinator(navigationController: navigationController)
        coordinator.start()

        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
        
        guard let url = URLContexts.first?.url,
              let scheme = url.scheme,
              scheme.contains("com.googleusercontent.apps") else { return }
        
        GIDSignIn.sharedInstance.handle(url)
    }
}

extension SceneDelegate {
    private func initKakaoSDK() {
        KakaoSDK.initSDK(appKey: "0fc9af67a72e49041aa31ec49dcd8bc0")
    }
}
