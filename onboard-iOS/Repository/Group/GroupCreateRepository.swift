//
//  GroupCreateRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

protocol GroupCreateRepository {
    func requestRandomImage() async throws -> GroupCreateEntity
}

final class GroupCreateRepositoryImpl: GroupCreateRepository {
    
    func requestRandomImage() async throws -> GroupCreateEntity {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GroupCreateDTO.self,
                    router: OBRouter.randomImage
                )
            
            guard let data = result.value else {
                throw NetworkError.noExist
            }
            
            return data.toDomain()
        } catch {
            throw error
        }
    }
}

extension GroupCreateDTO {
    func toDomain() -> GroupCreateEntity {
        return GroupCreateEntity(uuid: self.uuid,
                                 url: self.url)
    }
}
