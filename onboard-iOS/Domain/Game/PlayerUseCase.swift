//
//  PlayerUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/18/24.
//

import Foundation

protocol PlayerUseCase {
    func fetchPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res
    func fetchValidateNickName(groupId: Int, nickname: String) async throws -> GuestNickNameEntity.Res
    func fetchAddPlayer(groupId: Int, req: AddPlayerEntity.Req) async throws -> AddPlayerEntity.Res
    func fetchAllPlayer(groupId: Int, gameId: Int) async throws -> GameLeaderboardEntity.Res
}

final class PlayerUseCasempl: PlayerUseCase {
    
    private let repository: PlayerRepository
    
    init(repository: PlayerRepository) {
        self.repository = repository
    }
    
    func fetchPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res {
        try await self.repository.requestPlayerList(groupId: groupId, size: size)
    }
    
    func fetchValidateNickName(groupId: Int, nickname: String) async throws -> GuestNickNameEntity.Res {
        try await self.repository.requestValidateNickName(groupId: groupId, nickname: nickname)
    }
    
    func fetchAddPlayer(groupId: Int, req: AddPlayerEntity.Req) async throws -> AddPlayerEntity.Res {
        try await self.repository.requestAddPlayer(groupId: groupId, req: req)
    }
    
    func fetchAllPlayer(groupId: Int, gameId: Int) async throws -> GameLeaderboardEntity.Res {
        try await self.repository.requestAllPlayerList(groupId: groupId, gameId: gameId)
    }
}
