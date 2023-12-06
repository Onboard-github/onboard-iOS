//
//  GroupCreateUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

protocol GroupCreateUseCase {
    func fetchFileUpload(file: File, purpose: Purpose) async throws -> GroupCreateEntity.Res
    func fetchRandomImage() async throws -> GroupCreateEntity.Res
}

final class GroupCreateUseCaseImpl: GroupCreateUseCase {
    
    private let repository: GroupCreateRepository
    
    init(repository: GroupCreateRepository) {
        self.repository = repository
    }
    
    func fetchFileUpload(file: File, purpose: Purpose) async throws -> GroupCreateEntity.Res {
        try await self.repository.requestFileUpload(file: file, purpose: purpose)
    }
    
    func fetchRandomImage() async throws -> GroupCreateEntity.Res {
        do {
            return try await self.repository.requestRandomImage()
        } catch {
            throw error
        }
    }
}
