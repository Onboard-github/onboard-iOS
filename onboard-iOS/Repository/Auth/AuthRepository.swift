//
//  AuthRepository.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/23.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {

    func signIn(req: AuthEntity.Req) async throws -> AuthEntity.Res {

        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: AuthDTO.self,
                    router: OBRouter.auth(
                        body: AuthRequest.Body(
                            type: req.type.rawValue,
                            token: req.token
                        ).encode()
                    )
                )

            guard let data = result.value else {
                throw NetworkError.noExist
            }

            return data.toDomain

        } catch {
            print(error.localizedDescription)

            throw error
        }
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
