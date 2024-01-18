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
            
            return data.toDomain()
        } catch {
            throw error
        }
    }
}

extension PlayerDTO {
    func toDomain() -> PlayerEntity.Res {
        let playerList = self.contents.map({
            PlayerEntity.Res.PlayerList(
                id: $0.id,
                role: $0.role,
                nickname: $0.nickname,
                level: $0.level
            )
        })
        return PlayerEntity.Res(
            contents: playerList,
            cursor: self.cursor,
            hasNext: self.hasNext
        )
    }
}
