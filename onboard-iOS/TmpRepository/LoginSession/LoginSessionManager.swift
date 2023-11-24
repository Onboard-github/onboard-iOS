//
//  LoginSessionManager.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import Foundation
import SwiftKeychainWrapper

class LoginSessionManager {
    static func setLoginSession(accessToken: String, refreshToken: String, type: UserLoginSessionType) {
        KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
        KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
        KeychainWrapper.standard.set(type.rawValue, forKey: "sessionType")
    }
    
    static func getLoginSession() -> UserLoginSessionData? {
        guard let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else {
            return nil
        }
        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken") else {
            return nil
        }
        guard let typeString = KeychainWrapper.standard.string(forKey: "sessionType"), let type = UserLoginSessionType(rawValue: typeString) else {
            return nil
        }
        return UserLoginSessionData(type: type, accessToken: accessToken, refreshToken: refreshToken)
    }
}
