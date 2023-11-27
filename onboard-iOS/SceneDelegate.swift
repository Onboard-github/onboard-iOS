//
//  SceneDelegate.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon

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

        let testUseCase = TestUseCaseImpl(repository: TestRepositoryImpl())
        let testReactor = TestReactor(
            useCase: testUseCase,
            appleUseCase: AppleLoginUseCaseImpl(
                appleLoginManager: AppleLoginManagerImpl(),
                authRepository: AuthRepositoryImpl()
            ),
            kakaoUseCase: KakaoLoginUseCaseImpl(
                kakaoLoginManager: KakaoLoginManagerImpl(),
                authRepository: AuthRepositoryImpl()
            )
        )
        //let testViewController = GroupSearchViewController(reactor: GroupSearchReactor(useCase: testUseCase))
        let testViewController = TestViewController(reactor: testReactor)

        UITabBar.appearance().tintColor = UIColor.black
        if let _ = LoginSessionManager.getLoginSession(), let _ = LoginSessionManager.getNickname() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
            self.window?.rootViewController = homeTabController
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: LoginSelectVC())
        }
        
        
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
    }
}

extension SceneDelegate {
    private func initKakaoSDK() {
        KakaoSDK.initSDK(appKey: "0fc9af67a72e49041aa31ec49dcd8bc0")
    }
}
