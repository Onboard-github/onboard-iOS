//
//  MemberEntity.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/5/24.
//

import Foundation

enum MemberEntity {
    
    struct Res {
        
    }
    
    struct MatchCountRes {
        let matchCount: Int
    }
    
    struct GroupMemberPatchRes {
        let id: Int
        let level: Int
        let nickname: String
        let role: String
    }
    
    struct GroupMemberPatchReq {
        let nickname: String
    }
}
