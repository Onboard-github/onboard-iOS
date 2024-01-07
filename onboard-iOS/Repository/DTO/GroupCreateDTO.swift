//
//  GroupCreateDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

enum GroupCreateRequest {
    struct Body: Encodable {
        let name: String
        let description: String
        let organization: String
        let profileImageUrl: String?
        let profileImageUuid: String
        let nickname: String
    }
}

struct GroupCreateCompleteDTO: Decodable {
    let id: Int
    let name: String
    let description: String
    let owner: String
    let organization: String
    let profileImageUrl: String
    let accessCode: String
}

struct GroupCreateDTO: Decodable {
    let uuid: String
    let url: String
}
