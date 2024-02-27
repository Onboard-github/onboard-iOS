//
//  GameResultRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/15/24.
//

import Foundation

protocol GameResultRepository {
    func requestResult(groupId: Int, sort: String) async throws -> GameResultEntity.Res
}

final class GameResultRepositoryImpl: GameResultRepository {
    
    func requestResult(groupId: Int, sort: String) async throws -> GameResultEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GameResultDTO.self,
                    router: OBRouter.gameResult(
                        groupId: groupId,
                        sort: sort
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

extension GameResultDTO {
    func toDomain() -> GameResultEntity.Res {
        let gameList = self.list.map({
            GameResultEntity.Res.GameList(
                id: $0.id,
                img: $0.img,
                matchCount: $0.matchCount,
                maxMember: $0.maxMember,
                minMember: $0.minMember,
                name: $0.name)
        })
        return GameResultEntity.Res(list: gameList)
    }
}
