//
//  GoogleLoginManager.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/09/19.
//

import Foundation
import GoogleSignIn

protocol GoogleLoginManager {
    func signIn(
        presentingViewController: UIViewController,
        delegate: GoogleLoginDelegate?
    )
}

class GoogleLoginManagerImpl: GoogleLoginManager {
    
    private var token: String = "" {
        didSet {
            self.delegate?.success(token: self.token)
        }
    }
    
    weak var delegate: GoogleLoginDelegate?
    
    func signIn(
        presentingViewController: UIViewController,
        delegate: GoogleLoginDelegate?
    ) {
        
        self.delegate = delegate
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController
        ) { signInResult, error in
            
            guard error == nil,
                  let result = signInResult,
                  let idToken = result.user.idToken?.tokenString else { return }
            
            self.token = idToken
        }
    }
}
