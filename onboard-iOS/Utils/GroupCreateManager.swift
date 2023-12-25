//
//  GroupCreateManager.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/17/23.
//

import Foundation
import UIKit

class GroupCreateManager {
    
    static let shared = GroupCreateManager()
    
    static let userDefaults = UserDefaults.standard
    
    static let imageKey = "imageKey"
    static let nameKey = "nameKey"
    static let descriptionKey = "descriptionKey"
    static let organizationKey = "organizationKey"
    static let ownerKey = "ownerKey"
    static let codeKey = "codeKey"
    static let urlKey = "urlKey"
    static let uuidKey = "profileImageUUIDKey"
    
    // MARK: - Set
    
    static func saveImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            userDefaults.set(imageData, forKey: GroupCreateManager.imageKey)
        }
    }
    
    static func saveName(_ name: String) {
        userDefaults.set(name, forKey: nameKey)
    }
    
    static func saveDescription(_ description: String) {
        userDefaults.set(description, forKey: descriptionKey)
    }
    
    static func saveOrganization(_ organization: String) {
        userDefaults.set(organization, forKey: organizationKey)
    }
    
    static func saveOwner(_ owner: String) {
        userDefaults.set(owner, forKey: ownerKey)
    }
    
    static func saveCode(_ code: String) {
        userDefaults.set(code, forKey: codeKey)
    }
    
    static func saveUrl(_ url: String) {
        userDefaults.set(url, forKey: urlKey)
    }
    
    static func saveUUID(_ uuid: String) {
        userDefaults.set(uuid, forKey: uuidKey)
    }
    
    // MARK: - Get
    
    static func getImage() -> UIImage? {
        if let imageData = userDefaults.data(forKey: imageKey) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    static func getName() -> String? {
        return userDefaults.string(forKey: nameKey)
    }
    
    static func getDescription() -> String? {
        return userDefaults.string(forKey: descriptionKey)
    }
    
    static func getOrganization() -> String? {
        return userDefaults.string(forKey: organizationKey)
    }
    
    static func getOwner() -> String? {
        return userDefaults.string(forKey: ownerKey)
    }
    
    static func getCode() -> String? {
        return userDefaults.string(forKey: codeKey)
    }
    
    static func getUrl() -> String? {
        return userDefaults.string(forKey: urlKey)
    }
    
    static func getSavedUUID() -> String? {
        return userDefaults.string(forKey: uuidKey)
    }
    
    static func logout() {
        let keys = [imageKey, nameKey, descriptionKey, organizationKey, ownerKey, codeKey]
        keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }
}
