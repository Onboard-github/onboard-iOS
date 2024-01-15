//
//  GetMyGroupsV2Res.swift
//  onboard-iOS
//
//  Created by m1pro on 1/16/24.
//

import Foundation

struct GetMyGroupsV2Res: Codable {
    var contents: [MyGroup]
}

struct MyGroup: Codable {
    var groupId: Int
    var groupName: String
    var nickname: String
    var organization: String
    var matchCount: Int
    var memberId: Int
}
