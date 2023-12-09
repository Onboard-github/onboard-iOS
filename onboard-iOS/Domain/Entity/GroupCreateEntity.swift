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
    
    struct Req {
        
    }
    
    struct Res {
        let uuid: String
        let url: String
    }
}
