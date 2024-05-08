//
//  MemberRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/5/24.
//

import Foundation
import Alamofire

protocol MemberRepository {
    func requestAssignOwner(groupId: Int, memberId: Int) async throws -> MemberEntity.Res
    func requestMemberUnsubscribe(groupId: Int) async throws
    func requestMatchCount(groupId: Int, memberId: Int) async throws -> MemberEntity.MatchCountRes
    func requestGroupMemberPatch(req: MemberEntity.GroupMemberPatchReq, groupId: Int, memberId: Int) async throws -> MemberEntity.GroupMemberPatchRes
}

final class MemberRepositoryImpl: MemberRepository {
    
    func requestAssignOwner(groupId: Int, memberId: Int) async throws -> MemberEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: MemberDTO.self,
                    router: OBRouter.assignOwner(
                        groupId: groupId,
                        memberId: memberId
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
    
    func requestMemberUnsubscribe(groupId: Int) async throws {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: Empty.self,
                    router: OBRouter.myGroupUnsubscribe(
                        groupId: groupId
                    )
                )
        } catch {
            throw error
        }
    }
    
    func requestMatchCount(groupId: Int, memberId: Int) async throws -> MemberEntity.MatchCountRes {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: MatchCountDTO.self,
                    router: OBRouter.getMatchCount(
                        groupId: groupId,
                        memberId: memberId
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
    
    func requestGroupMemberPatch(req: MemberEntity.GroupMemberPatchReq, groupId: Int, memberId: Int) async throws -> MemberEntity.GroupMemberPatchRes {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GroupMemberPatchDTO.self,
                    router: OBRouter.groupMemeberPatch(
                        groupId: groupId,
                        memberId: memberId,
                        body: GroupMemberPatchRequest.Body(
                            nickname: req.nickname
                        ).encode()
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
}

extension MemberDTO {
    func toDomain() -> MemberEntity.Res {
        return MemberEntity.Res()
    }
}

extension MatchCountDTO {
    func toDomain() -> MemberEntity.MatchCountRes {
        return MemberEntity.MatchCountRes(
            matchCount: self.matchCount
        )
    }
}

extension GroupMemberPatchDTO {
    func toDomain() -> MemberEntity.GroupMemberPatchRes {
        return MemberEntity.GroupMemberPatchRes(
            id: self.id,
            level: self.level,
            nickname: self.nickname,
            role: self.role
        )
    }
}
