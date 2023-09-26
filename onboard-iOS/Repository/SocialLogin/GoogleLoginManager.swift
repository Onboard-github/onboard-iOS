//
//  GoogleLoginManager.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/09/19.
//

import Foundation
import GoogleSignIn
import JWTDecode

class GoogleLoginManager {
    
    static let shared = GoogleLoginManager()
    
    func signIn(withPresenting presentingViewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            
            if error == nil {
                guard let signInResult = signInResult else { return }
                let user = signInResult.user
                
                print("user: \(signInResult.user)")
                print("email: \(user.profile?.email ?? "no email")")
                print("name: \(user.profile?.name ?? "no userName")")
                print("token: \(user.accessToken)")
                print("refreshToken: \(user.refreshToken)")
                print("idToken: \(user.idToken)")

                if let idToken = user.idToken {
                    let idTokenString = idToken.tokenString
                    
                    do {
                        let jwt = try decode(jwt: idTokenString)
                        
                        let networkManager = OBNetworkManager.shared
                        networkManager.googleLoginRequest(token: idTokenString)
                    } catch {
                        print("JWT 디코딩 오류: \(error)")
                    }
                }
                
                let tokenString = user.accessToken.tokenString
                let refreshTokenString = user.refreshToken.tokenString
                
                print("token: \(tokenString)")
                print("refreshToken: \(refreshTokenString)")
            } else {
                print("Google 로그인 실패: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
