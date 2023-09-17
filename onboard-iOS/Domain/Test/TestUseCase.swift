//
//  SignUpUseCase.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

protocol TestUseCase {
    func fetchTestAPi() async throws -> TestEntity
}

final class TestUseCaseImpl {

    private let repository: TestRepository

    init(repository: TestRepository) {
        self.repository = repository
    }

    func fetchTestAPi() async throws -> TestEntity {
        do {
            return try await self.repository.requestTestAPI()

        } catch {

            throw error
        }

    }

}
