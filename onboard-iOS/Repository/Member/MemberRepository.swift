//
//  MemberRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/5/24.
//

import Foundation

protocol MemberRepository {
    func requestAssignOwner(groupId: Int, memberId: Int) async throws -> MemberEntity.Res
}
