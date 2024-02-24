//
//  GameEntity.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/15/24.
//

import Foundation

struct GameResultEntity {
    struct Res {
        let list: [GameList]
        
        struct GameList: Codable {
            let id: Int
            let img: String
            let matchCount: Int
            let maxMember: Int
            let minMember: Int
            let name: String
        }
    }
}

struct PlayerEntity {
    struct Res {
        let contents: [PlayerList]
        
        let cursor: String
        let hasNext: Bool
        
        struct PlayerList: Codable {
            let id: Int
            let role: String
            let nickname: String
            let level: Int
            var score: String?
        }
    }
}

struct AddPlayerEntity {
    struct Res {
        
    }
    
    struct Req {
        let nickname: String
    }
}
