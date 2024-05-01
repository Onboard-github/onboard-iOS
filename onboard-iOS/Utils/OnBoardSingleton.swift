//
//  GroupCreateSingleton.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/17/23.
//

import Foundation

import RxSwift
import RxCocoa

final class OnBoardSingleton {
    
    static let shared = OnBoardSingleton()
    
    var groupImageUuid = BehaviorRelay<String>(value: "")
    var groupImageUrl = BehaviorRelay<String>(value: "")
    var nameText = BehaviorRelay<String>(value: "")
    var descriptionText = BehaviorRelay<String>(value: "")
    var organizationText = BehaviorRelay<String>(value: "")
    var ownerText = BehaviorRelay<String>(value: "")
    var accessCodeText = BehaviorRelay<String>(value: "")
    
    var newUserNameText = BehaviorRelay<String>(value: "")
    var newGroupUserNameText = BehaviorRelay<String>(value: "")
}
