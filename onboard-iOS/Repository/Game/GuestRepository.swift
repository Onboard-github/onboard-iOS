//
//  GuestRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/24/24.
//

import Foundation

protocol GuestRepository {
    func requestValidateNickName(groupId: Int, nickname: String) async throws -> GuestNickNameEntity.Res
}

final class GuestRepositoryImpl: GuestRepository {
    
    func requestValidateNickName(groupId: Int, nickname: String) async throws -> GuestNickNameEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GuestNicknameDTO.self,
                    router: OBRouter.validateNicknameGuest(
                        params: [
                            "groupId": groupId,
                            "nickname": nickname
                        ]
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
