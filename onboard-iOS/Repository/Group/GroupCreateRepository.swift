//
//  GroupCreateRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

protocol GroupCreateRepository {
    func requestRandomImage() async throws -> GroupCreateEntity.Res
}

final class GroupCreateRepositoryImpl: GroupCreateRepository {
    
    func requestRandomImage() async throws -> GroupCreateEntity.Res {
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
    func toDomain() -> GroupCreateEntity.Res {
        return GroupCreateEntity.Res(uuid: self.uuid,
                                     url: self.url)
    }
}
