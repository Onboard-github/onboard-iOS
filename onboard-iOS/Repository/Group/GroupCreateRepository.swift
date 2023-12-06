//
//  GroupCreateRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

protocol GroupCreateRepository {
    func requestFileUpload(file: File, purpose: Purpose) async throws -> GroupCreateEntity.Res
    func requestRandomImage() async throws -> GroupCreateEntity.Res
}

final class GroupCreateRepositoryImpl: GroupCreateRepository {
    
    func requestFileUpload(file: File, purpose: Purpose) async throws -> GroupCreateEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncFileUploadRequest(
                    object: GroupCreateDTO.self,
                    router: OBRouter.pickerImage(
                        params: ["file": file,
                                 "purpose": purpose]),
                        file: file
                )
            
            guard let data = result.value else {
                throw NetworkError.noExist
            }
            
            return data.toDomain()
        } catch {
            throw error
        }
    }
    
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
