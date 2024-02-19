//
//  MatchDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/19/24.
//

import Foundation

enum MatchRequest {
    struct Body: Encodable {
        let gameId: Int
        let groupId: Int
        let matchedDate: String
        
        let matchMembers: [Match]
        
        struct Match: Encodable {
            let memberId: Int
            let score: Int
            let ranking: Int
        }
    }
}

struct MatchDTO: Decodable {
    
}
