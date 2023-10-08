//
//  KakaoLoginManager.swift
//  onboard-iOS
//
//  Created by main on 2023/10/03.
//

import Foundation
import KakaoSDKUser

protocol KakaoLoginManager {
    func excute(delegate: KakaoLoginDelegate)
}

final class KakaoLoginManagerImpl: NSObject, KakaoLoginManager {

    private var token: String = "" {
        didSet {
            self.delegate?.sendOAuthToken(self.token)
        }
    }

    weak var delegate: KakaoLoginDelegate?

    func excute(delegate: KakaoLoginDelegate) {
        self.delegate = delegate
        if (UserApi.isKakaoTalkLoginAvailable()) {
            kakaoTalkLogin()
        } else {
            kakaoAccountLogin()
        }
    }
}

extension KakaoLoginManagerImpl {
    private func kakaoTalkLogin() {
        UserApi.shared.loginWithKakaoTalk {[weak self] (oauthToken, error) in
            guard let self = self else { return }
            guard let oauthToken = oauthToken else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            self.token = oauthToken.accessToken
        }
    }
    
    private func kakaoAccountLogin() {
        UserApi.shared.loginWithKakaoAccount {[weak self] (oauthToken, error) in
            guard let self = self else { return }
            guard let oauthToken = oauthToken else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            self.token = oauthToken.accessToken
        }
    }
}
