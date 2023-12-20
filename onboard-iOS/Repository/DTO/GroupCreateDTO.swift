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
    let id: Int?
    let name: String?
    let description: String?
    let owner: String?
    let organization: String?
    let profileImageUrl: String?
    let accessCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case owner = "owner"
        case organization = "organization"
        case profileImageUrl = "profileImageUrl"
        case accessCode = "accessCode"
    }
}

struct GroupCreateDTO: Decodable {
    let uuid: String
    let url: String
}
