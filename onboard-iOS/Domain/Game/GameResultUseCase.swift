//
//  GameResultUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/15/24.
//

import Foundation

protocol GameResultUseCase {
    func fetchResult(groupId: Int, sort: String) async throws -> GameResultEntity.Res
}

final class GameResultUseCaseImpl: GameResultUseCase {
    
    private let repository: GameResultRepository
    
    init(repository: GameResultRepository) {
        self.repository = repository
    }
    
    func fetchResult(groupId: Int, sort: String) async throws -> GameResultEntity.Res {
        try await self.repository.requestResult(groupId: groupId, sort: sort)
    }
}
