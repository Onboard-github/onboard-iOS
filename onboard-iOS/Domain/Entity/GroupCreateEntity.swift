//
//  GroupCreateEntity.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/1/23.
//

import Foundation

enum Purpose: String {
    case GROUP_IMAGE = "GROUP_IMAGE"
    case MATCH_IMAGE = "MATCH_IMAGE"
}

struct File {
    let name: String
    let data: Data
    let mimeType: String
}

struct GroupCreateEntity {
    struct Res {
        let uuid: String
        let url: String
    }
}

struct GroupCreateCompleteEntity {
    struct Res {
        let id: Int
        let name: String
        let description: String
        let owner: String
        let organization: String
        let profileImageUrl: String
        let accessCode: String
    }
    
    struct Req {
        let name: String
        let description: String
        let organization: String
        let profileImageUrl: String?
        let profileImageUuid: String
        let nickname: String
    }
}
