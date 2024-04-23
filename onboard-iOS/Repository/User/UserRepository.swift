//
//  UserRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/23/24.
//

import Foundation

protocol UserRepository {
    func requestMeInfo(req: UpdateMyNicknameEntity.Req) async throws -> UpdateMyNicknameEntity.Res
}

final class UserRepositoryImpl: UserRepository {
    
    func requestMeInfo(req: UpdateMyNicknameEntity.Req) async throws -> UpdateMyNicknameEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: UserDTO.self,
                    router: .setUser(
                        body: UpdateMyNicknameRequest.Body(
                            nickname: req.nickname
                        ).encode()
                    )
                )
            
            guard let data = result.value else {
                throw NetworkError.noExist
            }
            
            return data.toDomain()
        } catch {
            throw error
        }
    }
}
