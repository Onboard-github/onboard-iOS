//
//  GroupRepository.swift
//  onboard-iOS
//
//  Created by main on 2023/10/15.
//

import Foundation
import Alamofire

protocol GroupRepository {
    func list(keyword: String?, pageNumber: Int, pageSize: Int) async throws -> GroupEntity.Res
    func requestInfo(groupId: Int) async throws -> GroupInfoEntity.Res
    func requestGroupDelete(groupId: Int) async throws
}

final class GroupRepositoryImpl: GroupRepository {
    
    func list(keyword: String? = nil, pageNumber: Int = 0, pageSize: Int = 10) async throws -> GroupEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GroupDTO.self,
                    router: OBRouter.groupList(params: ["keyword": keyword ?? "", "pageNumber": "\(pageNumber)", "pageSize": "\(pageSize)"])
                )
            
            guard let data = result.value else {
                throw NetworkError.noExist
            }
            
            return data.toDomain
            
        } catch {
            print(error.localizedDescription)
            
            throw error
        }
    }
    
    func requestInfo(groupId: Int) async throws -> GroupInfoEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GroupInfoRes.self,
                    router: OBRouter.groupInfo(
                        groupId: groupId
                    )
                )
            
            guard let data = result.value else {
                throw NetworkError.noExist
            }
            
            return data.toDomain()
        } catch {
            throw error
        }
    }
    
    func requestGroupDelete(groupId: Int) async throws {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: Empty.self,
                    router: OBRouter.groupDelete(
                        groupId: groupId
                    )
                )
        } catch {
            throw error
        }
    }
}

extension GroupDTO {
    var toDomain: GroupEntity.Res {
        let groupList = self.content.map({GroupEntity.Res.Group(id: $0.id, name: $0.name, description: $0.description, organization: $0.organization, profileImageUrl: $0.profileImageUrl)})
        return GroupEntity.Res(contents: groupList)
    }
}

extension GroupInfoRes {
    func toDomain() -> GroupInfoEntity.Res {
        
        return GroupInfoEntity.Res(
            id: id,
            name: name,
            description: description,
            organization: organization,
            profileImageUrl: profileImageUrl,
            accessCode: accessCode,
            memberCount: memberCount,
            owner: GroupInfoEntity.groupOwner(
                id: owner.id,
                role: owner.role,
                nickname: owner.nickname,
                level: owner.level
            ),
            isRegister: isRegister)
    }
}
