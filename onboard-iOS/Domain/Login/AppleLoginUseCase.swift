//
//  AppleLoginUseCase.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/18.
//

import Foundation

protocol AppleLoginUseCase {
    // 로그인
    func signIn() async
}

protocol AppleLoginDelegate: AnyObject {
    // 애플로그인 토큰 발급
    func success(token: String)
}

protocol AuthRepository {
    // api 호출 및 토큰 가져오기
    func signIn(req: AuthEntity.Req) async throws -> AuthEntity.Res
}

final class AppleLoginUseCaseImpl: AppleLoginUseCase {

    private let appleLoginManager: AppleLoginManager
    private let authRepository: AuthRepository

    init(
        appleLoginManager: AppleLoginManager,
        authRepository: AuthRepository
    ) {
        self.appleLoginManager = appleLoginManager
        self.authRepository = authRepository
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

            print(result)
        }
    }
}
