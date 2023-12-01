//
//  GroupCreateEntity.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/1/23.
//

import Foundation

enum GroupCreateEntity {
    
    struct Res {
        let randomImage: [RandomImage]
        
        struct RandomImage: Codable {
            let uuid: String
            let url: String
        }
    }
    
    struct Req {
        let randomImage: [RandomImage]
        
        struct RandomImage {
            let file: String
            let purpose: ImageFilePurpose
        }
    }
}
