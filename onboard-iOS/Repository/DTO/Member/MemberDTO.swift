//
//  MemberDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/5/24.
//

import Foundation

struct MemberDTO: Decodable {
    
}

struct MatchCountDTO: Decodable {
    let matchCount: Int
}

struct GroupMemberPatchDTO: Decodable {
    let id: Int
    let level: Int
    let nickname: String
    let role: String
}

enum GroupMemberPatchRequest {
    struct Body: Encodable {
        let nickname: String
    }
}
