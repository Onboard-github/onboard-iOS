//
//  UuidManager.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/17/23.
//

import Foundation

class UUIDManager {
    static let shared = UUIDManager()

    private let userDefaults = UserDefaults.standard
    private let uuidKey = "profileImageUUIDKey"

    func saveUUID(_ uuid: String) {
        userDefaults.set(uuid, forKey: uuidKey)
    }

    func getSavedUUID() -> String? {
        return userDefaults.string(forKey: uuidKey)
    }
}
