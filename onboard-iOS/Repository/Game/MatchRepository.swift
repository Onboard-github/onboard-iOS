//
//  MatchRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/19/24.
//

import Foundation

protocol MatchRepository {
    func requestMatch(req: MatchEntity.Req) async throws -> MatchEntity.Res
}

final class MatchRepositoryImpl: MatchRepository {
    
    func requestMatch(req: MatchEntity.Req) async throws -> MatchEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: MatchDTO.self,
                    router: OBRouter.match(
                        body: MatchRequest.Body(
                            gameId: req.gameId,
                            groupId: req.groupId,
                            matchedDate: req.matchedDate,
                            matchMembers: req.matchMembers
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


extension MatchDTO {
    func toDomain() -> MatchEntity.Res {
        return MatchEntity.Res()
    }
}
