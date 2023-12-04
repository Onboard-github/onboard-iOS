//
//  GoogleLoginUseCase.swift
//  onboard-iOS
//
//  Created by 윤다예 on 12/3/23.
//

import Foundation

import RxSwift

protocol GoogleLoginUseCase {
    var result: Observable<OnboardingEntity> { get }
    func signIn(token: String) async throws
}

protocol GoogleLoginDelegate: AnyObject {
    // 구글로그인 토큰 전달
    func success(token: String) 
}

final class GoogleLoginUseCaseImpl: GoogleLoginUseCase {

    private let authRepository: AuthRepository
    private let keychainService: KeychainService

    var result: Observable<OnboardingEntity>
    private let _result: PublishSubject<OnboardingEntity> = .init()

    init(
        authRepository: AuthRepository,
        keychainService: KeychainService
    ) {
        self.authRepository = authRepository
        self.keychainService = keychainService
        self.result = self._result
    }
    
    func signIn(token: String) async throws {
        self.removeKeychainData()
        
        let authResult = try await self.authRepository.signIn(
            req: AuthEntity.Req(type: .google, token: token)
        )
        self.keychainService.set(authResult.accessToken, forKey: .accessToken)
        self.keychainService.set(authResult.refreshToken, forKey: .refreshToken)
        
        let onboardingResult = try await self.authRepository.onboarding()
        
        self._result.onNext(onboardingResult)
    }
    
    private func removeKeychainData() {
        self.keychainService.remove(forKey: .accessToken)
        self.keychainService.remove(forKey: .refreshToken)
    }
}
