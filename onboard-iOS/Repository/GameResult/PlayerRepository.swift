//
//  PlayerRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/18/24.
//

import Foundation

protocol PlayerRepository {
    func requestPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res
}

final class PlayerRepositoryImpl: PlayerRepository {
    func requestPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: PlayerDTO.self,
                    router: OBRouter.gamePlayer(
                        params: ["groupId": groupId,
                                 "size": size]
                    )
                )
            
            guard let data = result.value else {
                throw NetworkError.noExist
            }
        } catch {
            throw error
        }
    }
}
