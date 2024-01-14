//
//  groupMembersRes.swift
//  onboard-iOS
//
//  Created by m1pro on 1/11/24.
//

import Foundation

struct GroupMembersRes: Codable {
    var cursor: String
    var hasNext: Bool
    var contents: [MemberInfo]
}

struct MemberInfo: Codable {
    var role: String //     맴버 종류 구분 oneOf [OWNER, HOST, GUEST]
    var level: Int //    주사위 모양 데이터
    var nickname: String
    var id: Int
}
