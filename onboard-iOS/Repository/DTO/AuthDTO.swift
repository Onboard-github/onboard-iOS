//
//  AuthDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/09/29.
//

import Foundation

enum AuthRequest {
    struct Body: Encodable {
        let type: String
        let token: String
    }
}

struct AuthDTO: Decodable {
    let accessToken: String?
    let refreshToken: String?
}

