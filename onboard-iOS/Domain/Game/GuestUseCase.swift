//
//  GuestUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/24/24.
//

import Foundation

protocol GuestUseCase {
    func fetchValidateNickName(groupId: Int, nickname: String) async throws -> GuestNickNameEntity.Res
}

final class GuestUseCaseImpl: GuestUseCase {
    
    private let repository: GuestRepository
    
    init(repository: GuestRepository) {
        self.repository = repository
    }
    
    func fetchValidateNickName(groupId: Int, nickname: String) async throws -> GuestNickNameEntity.Res {
        try await self.repository.requestValidateNickName(groupId: groupId, nickname: nickname)
    }
}
