//
//  GoogleLoginManager.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/09/19.
//

import Foundation
import GoogleSignIn

class GoogleLoginManager {
    
    static let shared = GoogleLoginManager()
    
    func signIn(withPresenting presentingViewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            
            if error == nil {
                guard let signInResult = signInResult else { return }
                let user = signInResult.user
                
                print("accessToken: \(user.accessToken)")
                print("refreshToken: \(user.refreshToken)")
                
            } else {
                print("Google 로그인 실패: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
