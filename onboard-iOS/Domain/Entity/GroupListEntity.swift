//
//  GroupListEntity.swift
//  onboard-iOS
//
//  Created by main on 2023/10/15.
//

import Foundation

enum GroupEntity {
    struct Res {
        let contents: [Group]

        struct Group: Codable {
            let id: Int
            let name: String
            let description: String
            let organization: String
            let profileImageUrl: String
        }
    }

    struct Req {}
}
