//
//  PlayerUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/18/24.
//

import Foundation

protocol PlayerUseCase {
    func fetchPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res
}

final class PlayerUseCasempl: PlayerUseCase {
    
    private let repository: PlayerRepository
    
    init(repository: PlayerRepository) {
        self.repository = repository
    }
    
    func fetchPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res {
        try await self.repository.requestPlayerList(groupId: groupId, size: size)
    }
}
