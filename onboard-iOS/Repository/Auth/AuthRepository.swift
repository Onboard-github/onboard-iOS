//
//  AuthRepository.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/23.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {

    func signIn(req: AuthEntity.Req) async throws -> AuthEntity.Res {

        // 안타깝게도 API가 아직 애플을 지원하지 않습니다..
        // Mock Return(exist account)
        return AuthEntity.Res(
            accessToken: "test_accessToken",
            refreshToken: "test_refreshToken"
        )
        // Mock Return(No exist)
//        return AuthEntity.Res(
//            accessToken: nil,
//            refreshToken: nil
//        )

        // API version
//        do {
//            let result = try await OBNetworkManager
//                .shared
//                .asyncRequest(
//                    object: AuthDTO.self,
//                    router: OBRouter.auth(
//                        body: AuthRequest.Body(
//                            type: req.type.rawValue,
//                            token: req.token
//                        ).encode()
//                    )
//                )
//
//            guard let data = result.value else {
//                throw NetworkError.noExist
//            }
//
//            return data.toDomain
//
//        } catch {
//            print(error.localizedDescription)
//
//            throw error
//        }
    }
}

extension AuthDTO {
    var toDomain: AuthEntity.Res {
        return AuthEntity.Res(
            accessToken: self.accessToken,
            refreshToken: self.refreshToken
        )
    }
}
