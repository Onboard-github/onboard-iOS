//
//  AppleLoginUseCase.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/18.
//

import Foundation

import RxSwift

protocol AppleLoginUseCase {
    var result: Observable<OnboardingEntity> { get }
    func signIn() async
}

protocol AppleLoginDelegate: AnyObject {
    // 애플로그인 토큰 발급
    func success(token: String)
}

protocol AuthRepository {
    // api 호출 및 토큰 가져오기
    func signIn(req: AuthEntity.Req) async throws -> AuthEntity.Res
    func onboarding() async throws -> OnboardingEntity
}

final class AppleLoginUseCaseImpl: AppleLoginUseCase {

    private let appleLoginManager: AppleLoginManager
    private let authRepository: AuthRepository
    private let keychainService: KeychainService

    var result: Observable<OnboardingEntity>
    private let _result: PublishSubject<OnboardingEntity> = .init()

    init(
        appleLoginManager: AppleLoginManager,
        authRepository: AuthRepository,
        keychainService: KeychainService
    ) {
        self.appleLoginManager = appleLoginManager
        self.authRepository = authRepository
        self.keychainService = keychainService
        self.result = self._result
    }

    func signIn() async {
        self.removeKeychainData()
        self.appleLoginManager.excute(delegate: self)
    }
    
    private func removeKeychainData() {
        self.keychainService.remove(forKey: .accessToken)
        self.keychainService.remove(forKey: .refreshToken)
    }
}

// MARK: - Apple login delegate

extension AppleLoginUseCaseImpl: AppleLoginDelegate {

    func success(token: String) {
        Task {
            let authResult = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .apple, token: token)
            )
            self.keychainService.set(authResult.accessToken, forKey: .accessToken)
            self.keychainService.set(authResult.refreshToken, forKey: .refreshToken)
            
            let onboardingResult = try await self.authRepository.onboarding()
            
            self._result.onNext(onboardingResult)
        }
    }
}
