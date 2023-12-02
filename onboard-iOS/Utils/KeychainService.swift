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

final class KeychainService {
    
    private var keychain: KeychainWrapper {
        return KeychainWrapper.standard
    }
    
    func setKeychain(_ value: String, forKey keychainKey: KeychainKey) {
        self.keychain.set(value, forKey: keychainKey.rawValue)
    }
    func getKeychainValue(forKey keychainKey: KeychainKey) -> String? {
        return self.keychain.string(forKey: keychainKey.rawValue)
    }
    func removeKeychain(forKey keychainKey: KeychainKey) {
        self.keychain.removeObject(forKey: keychainKey.rawValue)
    }

}
