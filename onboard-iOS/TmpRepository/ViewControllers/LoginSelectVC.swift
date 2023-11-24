//
//  LoginSelectVC.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit
import PanModal

class LoginSelectVC: UIViewController {
    
    let kakaoLoginManager = KakaoLoginManagerImpl()
    let authRepository = AuthRepositoryImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func kakaoLogin(_ sender: Any) {
        kakaoLoginManager.excute(delegate: self)
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        AlertManager.show(message: "구글 로그인 미구현")
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        AlertManager.show(message: "애플 로그인 미구현")
    }
}

extension LoginSelectVC: KakaoLoginDelegate {
    func sendOAuthToken(_ token: String) {
        Task {
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .kakao, token: token)
            )
            
            if let currentSesison = LoginSessionManager.getLoginSession() {
                LogManager.log(messaeg: "기존 로그인되어있던 로그인 정보 \(currentSesison) 삭제")
            }
            
            LoginSessionManager.setLoginSession(accessToken: result.accessToken, refreshToken: result.refreshToken, type: .kakao)
        }
        let agree = AgreeVC()
        presentPanModal(agree)
    }
}
