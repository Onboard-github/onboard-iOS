//
//  AuthDTO.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/23.
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
