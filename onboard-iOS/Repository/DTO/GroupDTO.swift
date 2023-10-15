//
//  GroupDTO.swift
//  onboard-iOS
//
//  Created by main on 2023/10/15.
//

import Foundation

struct GroupDTO: Decodable {
    let content: [Group]

    struct Group: Codable {
        let id: Int
        let name: String
        let description: String
        let organization: String
        let profileImageUrl: String
    }
}
