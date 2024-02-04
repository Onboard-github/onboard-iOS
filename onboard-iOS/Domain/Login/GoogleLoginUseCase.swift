//
//  GoogleLoginUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/5/24.
//

import UIKit

import RxSwift

protocol GoogleLoginDelegate: AnyObject {
    func loginSuccess(token: String)
}

protocol GoogleLoginUseCase {
    var result: Observable<Bool> { get }
    func signIn() async
}

final class GoogleLoginUseCaseImpl: GoogleLoginUseCase {
    
    private let googleLoginManager: GoogleLoginManager
    private let authRepository: AuthRepository

    var result: Observable<Bool>
    private let _result: PublishSubject<Bool> = .init()
    
    init(
        googleLoginManager: GoogleLoginManager,
        authRepository: AuthRepository
    ) {
        self.googleLoginManager = googleLoginManager
        self.authRepository = authRepository
        self.result = self._result
    }

    func signIn() async {
        await self.googleLoginManager.excute(presentingViewController: UIViewController(),
                                       delegate: self)
    }
}

// MARK: - Google login delegate

extension GoogleLoginUseCaseImpl: GoogleLoginDelegate {
    
    func loginSuccess(token: String) {
        Task {
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .google, token: token)
            )
            print("result \(result)")
            
            let isExisted = false
            print(result.accessToken)
            print("-=-----==========")
            print(result.refreshToken)
            
            self._result.onNext(isExisted)
        }

    }
}
