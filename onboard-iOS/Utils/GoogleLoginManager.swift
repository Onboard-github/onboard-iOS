//
//  GoogleLoginManager.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/5/24.
//

import Foundation

import GoogleSignIn

protocol GoogleLoginManager {
    func excute(presentingViewController: UIViewController,
                delegate: GoogleLoginDelegate)
}

final class GoogleLoginManagerImpl: NSObject, GoogleLoginManager {

    private var token: String = "" {
        didSet {
            self.delegate?.loginSuccess(token: self.token)
        }
    }
    
    weak var delegate: GoogleLoginDelegate?

    func excute(presentingViewController: UIViewController,
                delegate: GoogleLoginDelegate) {
        self.delegate = delegate
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if error == nil {
                guard let signInResult = signInResult else { return }
                let user = signInResult.user

                if let gidToken = user.idToken {
                    let accessTokenString = gidToken.tokenString
                    self.token = accessTokenString
                }
            } else {
                print("Google 로그인 실패: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
