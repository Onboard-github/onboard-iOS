//
//  MyGroupEntity.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/3/24.
//

import Foundation

enum MyGroupEntity {
    
    struct Res {
        let contents: [Group]

        struct Group: Codable {
            let id: Int
            let description: String
            let matchCount: Int
            let memberId: Int
            let name: String
            let nickname: String
            let organization: String
            let profileImageUrl: String
            let role: String
        }
    }
}
