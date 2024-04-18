//
//  AppleLoginManager.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/18.
//

import Foundation

import AuthenticationServices

protocol AppleLoginManager {
    func excute(delegate: AppleLoginDelegate)
}

final class AppleLoginManagerImpl: NSObject, AppleLoginManager {

    private var token: String = "" {
        didSet {
            self.delegate?.success(token: self.token)
        }
    }
    
    private var userName: String = "" {
        didSet {
            self.delegate?.userName(nickname: self.userName)
        }
    }

    weak var delegate: AppleLoginDelegate?

    func excute(delegate: AppleLoginDelegate) {
        self.delegate = delegate
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
}

extension AppleLoginManagerImpl: ASAuthorizationControllerDelegate {

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = appleIdCredential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else { return }

        self.token = tokenString
        
        guard let userName = appleIdCredential.fullName?.givenName else {
            return
        }
        self.userName = userName
        LoginSessionManager.setNickname(nickname: userName)
    }
}
