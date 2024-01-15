//
//  GameResultDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/15/24.
//

import Foundation

struct GameResultDTO: Decodable {
    let list: [GameList]
    
    struct GameList: Decodable {
        let id: Int
        let img: String
        let matchCount: Int
        let maxMember: Int
        let minMember: Int
        let name: String
    }
}
