//
//  GroupCreateUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

protocol GroupCreateUseCase {
    func fetchRandomImage() async throws -> GroupCreateEntity
}

final class GroupCreateUseCaseImpl: GroupCreateUseCase {
    
    private let repository: GroupCreateRepository
    
    init(repository: GroupCreateRepository) {
        self.repository = repository
    }
    
    func fetchRandomImage() async throws -> GroupCreateEntity {
        do {
            return try await self.repository.requestRandomImage()
        } catch {
            throw error
        }
    }
}
