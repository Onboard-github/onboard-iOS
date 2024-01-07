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
    
    func requestCreate(req: GroupCreateCompleteEntity.Req) async throws -> GroupCreateCompleteEntity.Res
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
    
    func requestCreate(req: GroupCreateCompleteEntity.Req) async throws -> GroupCreateCompleteEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GroupCreateCompleteDTO.self,
                    router: OBRouter.createGroup(
                        body: GroupCreateRequest.Body(
                            name: req.name,
                            description: req.description,
                            organization: req.organization,
                            profileImageUrl: req.profileImageUrl,
                            profileImageUuid: req.profileImageUuid,
                            nickname: req.nickname
                        ).encode()
                    )
                )
            
            guard let data = result.value else {
                throw NetworkError.noExist
            }
            
            return data.domain()
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

extension GroupCreateCompleteDTO {
    func domain() ->  GroupCreateCompleteEntity.Res {
        return GroupCreateCompleteEntity.Res(
            id: self.id,
            name: self.name,
            description: self.description,
            owner: self.owner,
            organization: self.organization,
            profileImageUrl: self.profileImageUrl,
            accessCode: self.accessCode
        )
    }
}
