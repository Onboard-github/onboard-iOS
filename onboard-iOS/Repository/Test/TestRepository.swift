//
//  SignUpRepository.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

protocol TestRepository {
    func requestTestAPI() async throws -> TestEntity
}

enum NetworkError: Error {
    case noExist
}


final class TestRepositoryImpl: TestRepository {

    func requestTestAPI() async throws -> TestEntity {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: TestDTO.self,
                    router: OBRouter.testAPI
                )

            guard let data = result.value else {
                throw NetworkError.noExist }

            return data.toDomain()
            
        } catch {
            print(error.localizedDescription)

            throw error
        }
    }
}

extension TestDTO {
    func toDomain() -> TestEntity {
        return TestEntity(text: self.value)
    }
}
