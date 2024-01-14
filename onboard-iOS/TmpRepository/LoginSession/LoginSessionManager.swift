//
//  LoginSessionManager.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import Foundation
import SwiftKeychainWrapper

class LoginSessionManager {
    enum State: String {
        case logout
        case needJoinGroup
        case login
    }
    
    static func setState(state: State) {
        KeychainWrapper.standard.set(state.rawValue, forKey: "state")
    }
    
    static func getState() -> State {
        return State(rawValue: KeychainWrapper.standard.string(forKey: "state") ?? "logout") ?? .logout
    }
    
    static func logout() {
        KeychainWrapper.standard.remove(forKey: "accessToken")
        KeychainWrapper.standard.remove(forKey: "refreshToken")
        KeychainWrapper.standard.remove(forKey: "sessionType")
        KeychainWrapper.standard.remove(forKey: "nickname")
        KeychainWrapper.standard.remove(forKey: "state")
        KeychainWrapper.standard.remove(forKey: "currentGroupId")
    }
    
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
    
    static func setNickname(nickname: String) {
        KeychainWrapper.standard.set(nickname, forKey: "nickname")
    }
    
    static func getNickname() -> String? {
        return KeychainWrapper.standard.string(forKey: "nickname")
    }
    
    static var currentGroupId: Int? {
        get {
            return KeychainWrapper.standard.integer(forKey: "currentGroupId")
        }
        
        set {
            if let id = newValue {
                KeychainWrapper.standard.set(id, forKey: "currentGroupId")
            } else {
                KeychainWrapper.standard.remove(forKey: "currentGroupId")
            }
        }
    }
}
