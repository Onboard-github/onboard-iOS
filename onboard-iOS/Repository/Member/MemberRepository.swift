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
}

extension MemberDTO {
    func toDomain() -> MemberEntity.Res {
        return MemberEntity.Res()
    }
}
