//
//  AppleLoginUseCase.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/18.
//

import Foundation

import RxSwift

protocol AppleLoginUseCase {
    var result: Observable<Bool> { get }
    func signIn() async
}

protocol AppleLoginDelegate: AnyObject {
    // 애플로그인 토큰 발급
    func success(token: String)
    func userName(nickname: String)
}

protocol AuthRepository {
    // api 호출 및 토큰 가져오기
    func signIn(req: AuthEntity.Req) async throws -> AuthEntity.Res
}

final class AppleLoginUseCaseImpl: AppleLoginUseCase {

    private let appleLoginManager: AppleLoginManager
    private let authRepository: AuthRepository

    var result: Observable<Bool>
    private let _result: PublishSubject<Bool> = .init()

    init(
        appleLoginManager: AppleLoginManager,
        authRepository: AuthRepository
    ) {
        self.appleLoginManager = appleLoginManager
        self.authRepository = authRepository
        self.result = self._result
    }

    func signIn() async {
        self.appleLoginManager.excute(delegate: self)
    }
}

// MARK: - Apple login delegate

extension AppleLoginUseCaseImpl: AppleLoginDelegate {

    func success(token: String) {
        Task {
            let result = try await self.authRepository.signIn(
                req: AuthEntity.Req(type: .apple, token: token)
            )

            // TODO: 온보딩 진행정보 받아오기 호출 구현
            // 임시로 false 처리
            let isExisted = false
            print(result.accessToken)
            print("-=-----==========")
            print(result.refreshToken)

            self._result.onNext(isExisted)
        }
    }
    
    func userName(nickname: String) {
        
    }
}
