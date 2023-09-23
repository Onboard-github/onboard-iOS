//
//  AppleLoginUseCase.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/18.
//

import Foundation

protocol AppleLoginUseCase {
    // 로그인
    func signIn() async -> Bool
}

protocol AppleLoginDelegate: AnyObject {
    // 애플로그인 토큰 발급
    func success(token: String)
}

protocol AppleResultDelegate: AnyObject {
}

protocol LoginRepository {
    // api 호출 및 토큰 가져오기
    func login(accessToken: String) async throws -> AuthEntity
}

final class AppleLoginUseCaseImpl: AppleLoginUseCase {

    private let appleLoginManager: AppleLoginManager
    private let loginRepository: LoginRepository?

    init(
        appleLoginManager: AppleLoginManager,
        loginRepository: LoginRepository? = nil
    ) {
        self.appleLoginManager = appleLoginManager
        self.loginRepository = loginRepository
    }

    func signIn() async -> Bool {
        self.appleLoginManager.excute(delegate: self)
        
        return true
    }
}

// MARK: - Apple login delegate

extension AppleLoginUseCaseImpl: AppleLoginDelegate {

    func success(token: String) {

        print(token)
//        Task {
//            let token = try await self.loginRepository.login(accessToken: token)
//        }
    }
}
