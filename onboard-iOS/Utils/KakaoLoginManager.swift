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
            
            self.token = self.oAuthToJWT(accessToken: oauthToken.accessToken)
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
            
            self.token = self.oAuthToJWT(accessToken: oauthToken.accessToken)
        }
    }
    
    private func oAuthToJWT(accessToken: String) -> String {
        let header = "{\"alg\":\"HS256\",\"typ\":\"JWT\"}"
        let payload = "{\"access_token\":\"\(accessToken)\"}"

        // 헤더와 페이로드를 base64 인코딩합니다.
        let headerData = header.data(using: .utf8)!.base64EncodedString()
        let payloadData = payload.data(using: .utf8)!.base64EncodedString()

        // 헤더와 페이로드를 JWT 형식으로 연결하여 JWT 문자열을 생성합니다.
        let jwt = "\(headerData).\(payloadData)"
        return jwt
    }
}
