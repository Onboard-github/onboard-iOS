//
//  UserLoginSessionData.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import Foundation

enum UserLoginSessionType: String, Codable {
    case kakao, google, apple
}

struct UserLoginSessionData: Codable {
    var type: UserLoginSessionType
    var accessToken: String
    var refreshToken: String
}
