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
    
    static var isAlreadySetup: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isAlreadySetup")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isAlreadySetup")
        }
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
    
    static var meId: Int? {
        get {
            UserDefaults.standard.integer(forKey: "meId")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "meId")
        }
    }
    
    static var meMemberId: Int? {
        get {
            UserDefaults.standard.integer(forKey: "meMemberId")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "meMemberId")
        }
    }
}

class ProfileManager {
    static func refresh() {
        Task {
            let result = try await OBNetworkManager.shared.asyncRequest(object: GetMyGroupsV2Res.self, router: .getMyGroupsV2)
            let meInfoResult = try await OBNetworkManager.shared.asyncRequest(object: GetMeRes.self, router: .getMe)
            profileName = meInfoResult.value?.nickname
            gameCount = result.value?.contents.map({$0.matchCount}).reduce(0, +)
        }
    }
    
    static var profileName: String? {
        get {
            UserDefaults.standard.string(forKey: "profileName")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "profileName")
        }
    }
    
    static var gameCount: Int? {
        get {
            UserDefaults.standard.integer(forKey: "gameCount")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "gameCount")
        }
    }
    
    static var gameList: String? {
        get {
            UserDefaults.standard.string(forKey: "gameList")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "gameList")
        }
    }
}
