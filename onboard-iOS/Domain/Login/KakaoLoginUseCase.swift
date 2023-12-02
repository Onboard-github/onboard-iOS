//
//  KakaoLoginUseCase.swift
//  onboard-iOS
//
//  Created by main on 2023/10/03.
//

import Foundation
import RxSwift

protocol KakaoLoginUseCase {
    var result: Observable<OnboardingEntity> { get }
    func signIn() async
}

protocol KakaoLoginDelegate: AnyObject {
    // kakao token 토큰 전달
    func sendOAuthToken(_ token: String)
}

final class KakaoLoginUseCaseImpl: KakaoLoginUseCase {

    private let kakaoLoginManager: KakaoLoginManager
    private let authRepository: AuthRepository
    private let keychainService = KeychainServiceImpl()

    var result: Observable<OnboardingEntity>
    private let _result: PublishSubject<OnboardingEntity> = .init()

    init(
        kakaoLoginManager: KakaoLoginManager,
        authRepository: AuthRepository
    ) {
        self.kakaoLoginManager = kakaoLoginManager
        self.authRepository = authRepository
        self.result = self._result
    }

    func signIn() async {
        self.kakaoLoginManager.excute(delegate: self)
    }
}

// MARK: - Kakao Login delegate

extension KakaoLoginUseCaseImpl: KakaoLoginDelegate {
    func sendOAuthToken(_ token: String) {
        Task {
            let authResult = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .kakao, token: token)
            )
            
            self.keychainService.set(authResult.accessToken, forKey: .accessToken)
            self.keychainService.set(authResult.refreshToken, forKey: .refreshToken)
            
            let onboardingResult = try await self.authRepository.onboarding()
            
            self._result.onNext(onboardingResult)
        }
    }
}
