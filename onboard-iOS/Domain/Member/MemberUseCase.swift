//
//  MemberUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/5/24.
//

import Foundation

protocol MemberUseCase {
    func fetchAssignOwner(groupId: Int, memberId: Int) async throws -> MemberEntity.Res
    func fetchMemberUnsubscribe(groupId: Int) async throws
    func fetchMatchCount(groupId: Int, memberId: Int) async throws -> MemberEntity.MatchCountRes
}

final class MemberUseCaseImpl: MemberUseCase {
    
    private let repository: MemberRepository
    
    init(repository: MemberRepository) {
        self.repository = repository
    }
    
    func fetchAssignOwner(groupId: Int, memberId: Int) async throws -> MemberEntity.Res {
        try await self.repository.requestAssignOwner(groupId: groupId, memberId: memberId)
    }
    
    func fetchMemberUnsubscribe(groupId: Int) async throws {
        try await self.repository.requestMemberUnsubscribe(groupId: groupId)
    }
    
    func fetchMatchCount(groupId: Int, memberId: Int) async throws -> MemberEntity.MatchCountRes {
        try await self.repository.requestMatchCount(groupId: groupId, memberId: memberId)
    }
}
