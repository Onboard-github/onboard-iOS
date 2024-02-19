//
//  MatchEntity.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/19/24.
//

import Foundation

enum MatchEntity {
    struct Req {
        let gameId: Int
        let groupId: Int
        let matchedDate: String
        
        let matchMembers: [MatchRequest.Body.Match]
    }
    
    struct Res {
        
    }
}
