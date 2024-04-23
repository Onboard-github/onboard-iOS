//
//  UserDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/23/24.
//

import Foundation

enum UpdateMyNicknameRequest {
    struct Body: Encodable {
        let nickname: String
    }
}

struct UserDTO: Decodable {
    
}
