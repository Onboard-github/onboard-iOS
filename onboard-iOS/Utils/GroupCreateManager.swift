//
//  GroupCreateManager.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/17/23.
//

import Foundation

class GroupCreateManager {
    
    static let shared = GroupCreateManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let nameKey = "nameKey"
    private let descriptionKey = "descriptionKey"
    private let organizationKey = "organizationKey"
    private let ownerKey = "ownerKey"
    private let urlKey = "urlKey"
    private let uuidKey = "profileImageUUIDKey"
    
    // MARK: - Set
    
    func saveName(_ name: String) {
        userDefaults.set(name, forKey: nameKey)
    }
    
    func saveDescription(_ description: String) {
        userDefaults.set(description, forKey: descriptionKey)
    }
    
    func saveOrganization(_ organization: String) {
        userDefaults.set(organization, forKey: organizationKey)
    }
    
    func saveOwner(_ owner: String) {
        userDefaults.set(owner, forKey: ownerKey)
    }
    
    func saveUrl(_ url: String) {
        userDefaults.set(url, forKey: urlKey)
    }
    
    func saveUUID(_ uuid: String) {
        userDefaults.set(uuid, forKey: uuidKey)
    }
    
    // MARK: - Get
    
    func getName() -> String? {
        return userDefaults.string(forKey: nameKey)
    }
    
    func getDescription() -> String? {
        return userDefaults.string(forKey: descriptionKey)
    }
    
    func getOrganization() -> String? {
        return userDefaults.string(forKey: organizationKey)
    }
    
    func getOwner() -> String? {
        return userDefaults.string(forKey: ownerKey)
    }
    
    func getUrl() -> String? {
        return userDefaults.string(forKey: urlKey)
    }
    
    func getSavedUUID() -> String? {
        return userDefaults.string(forKey: uuidKey)
    }
}
