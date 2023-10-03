//
//  KakaoLoginUseCase.swift
//  onboard-iOS
//
//  Created by main on 2023/10/03.
//

import Foundation
import RxSwift

protocol KakaoLoginUseCase {
    var result: Observable<Bool> { get }
    func signIn() async
}

protocol KakaoLoginDelegate: AnyObject {
    // kakao token 토큰 전달
    func sendOAuthToken(_ token: String)
}

final class KakaoLoginUseCaseImpl: KakaoLoginUseCase {

    private let kakaoLoginManager: KakaoLoginManager
    private let authRepository: AuthRepository

    var result: Observable<Bool>
    private let _result: PublishSubject<Bool> = .init()

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
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .kakao, token: token)
            )
            
            // TODO: 온보딩 진행정보 받아오기 호출 구현
            // 임시로 false 처리
            let isExisted = false
            print(result.accessToken)
            print(result.refreshToken)
            
            self._result.onNext(isExisted)
        }
    }
}
