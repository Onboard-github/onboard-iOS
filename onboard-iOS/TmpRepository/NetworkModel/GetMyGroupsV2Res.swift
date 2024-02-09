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
    var id: Int
    var name: String // "그룹 이름"
    var description: String // "그룹 설명"
    var organization: String // "그룹 소속"
    var profileImageUrl: String // "uuid"
    var memberId: Int
    var nickname: String
    var matchCount: Int
}
