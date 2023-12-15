//
//  GroupCreateDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

struct GroupCreateDTO: Decodable {
    let content: [Group]
    
    struct Group: Codable {
        let name: String
        let description: String
        let organization: String
        let profileImageUrl: String?
        let profileImageUuid: String
        let nickname: String
    }
    
    let uuid: String
    let url: String
}
