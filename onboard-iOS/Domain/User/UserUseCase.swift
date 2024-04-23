//
//  UserUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/23/24.
//

import Foundation

protocol UserUseCase {
    func fetchMeInfo(req: UpdateMyNicknameEntity.Req) async throws -> UpdateMyNicknameEntity.Res
}

final class UserUseCaseImpl: UserUseCase {
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func fetchMeInfo(req: UpdateMyNicknameEntity.Req) async throws -> UpdateMyNicknameEntity.Res {
        try await self.repository.requestMeInfo(req: req)
    }
}
