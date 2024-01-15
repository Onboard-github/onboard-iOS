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
                        params: ["groupId": groupId,
                                 "sort": sort]
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
