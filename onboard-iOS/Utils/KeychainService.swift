//
//  KeychainService.swift
//  onboard-iOS
//
//  Created by 윤다예 on 12/2/23.
//

import Foundation

import SwiftKeychainWrapper

enum KeychainKey: String {
    case accessToken
    case refreshToken
}

protocol KeychainService {
    func set(_ value: String, forKey keychainKey: KeychainKey)
    func value(forKey keychainKey: KeychainKey) -> String?
    func remove(forKey keychainKey: KeychainKey)
}

final class KeychainServiceImpl: KeychainService {
    
    private var keychain: KeychainWrapper {
        return KeychainWrapper.standard
    }
    
    /// 저장
    func set(_ value: String, forKey keychainKey: KeychainKey) {
        self.keychain.set(value, forKey: keychainKey.rawValue)
    }
    
    /// 불러오기
    func value(forKey keychainKey: KeychainKey) -> String? {
        return self.keychain.string(forKey: keychainKey.rawValue)
    }
    
    /// 삭제
    func remove(forKey keychainKey: KeychainKey) {
        self.keychain.removeObject(forKey: keychainKey.rawValue)
    }

}
