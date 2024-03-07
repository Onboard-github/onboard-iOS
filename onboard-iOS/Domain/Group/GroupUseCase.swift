//
//  GroupUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/8/24.
//

import Foundation

protocol GroupUseCase {
    func fetchInfo(groupId: Int) async throws -> GroupInfoEntity.Res
    func fetchGroupDelete(groupId: Int) async throws
}

final class GroupUseCaseImpl: GroupUseCase {
    
    private let repository: GroupRepository
    
    init(repository: GroupRepository) {
        self.repository = repository
    }
    
    func fetchInfo(groupId: Int) async throws -> GroupInfoEntity.Res {
        try await self.repository.requestInfo(groupId: groupId)
    }
    
    func fetchGroupDelete(groupId: Int) async throws {
        try await self.repository.requestGroupDelete(groupId: groupId)
    }
}
