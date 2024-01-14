//
//  GroupInfoRes.swift
//  onboard-iOS
//
//  Created by m1pro on 1/14/24.
//

import Foundation

struct GroupInfoRes: Codable {
    var owner: Owner
    var memberCount: Int //그룹 멤버 수
    var accessCode: String // 그룹 참여 코드
    var organization: String //그룹 소속
    var name: String // 그룹 이름
    var description: String // 그룹 설명
    var id: Int // 그룹 ID
    var profileImageUrl: String // 그룹 프로필 이미지 URL
    var isRegister: Bool // 해당 그룹 가입 여부
}

struct Owner: Codable {
    var role: String //OWNER 로 고정 oneOf [OWNER, HOST, GUEST]
    var level: Int //주사위 등급
    var nickname: String //Owner 닉네임
    var id: Int // Owner ID
}
