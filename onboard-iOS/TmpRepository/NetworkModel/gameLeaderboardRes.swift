//
//  gameLeaderboardRes.swift
//  onboard-iOS
//
//  Created by m1pro on 2/19/24.
//

import Foundation

struct GameLeaderboardRes: Codable {
    var contents: [LeaderboardGame] //그룹 목록
}

struct LeaderboardGame: Codable {
    var score: Int? //승점
    var role: String // 맴버 종류 oneOf [OWNER, HOST, GUEST]
    var nickname: String //맴버 닉네임
    var rank: Int? // 등수, 1부터 시작
    var isChangeRecent: Bool //최근(1시간 이내) 변경점이 존재하는 지 여부
    var matchCount: Int? //총 플레이 횟수
    var userId: Int? //맴버의 User ID, 게스트는 null
    var memberId: Int //맴버 ID
}

struct GameLeaderboardEntity {
    struct Res {
        var contents: [LeaderboardGame]
        
        struct LeaderboardGame: Codable {
            var score: Int
            var role: String
            var nickname: String
            var rank: Int
            var isChangeRecent: Bool
            var matchCount: Int
            var userId: Int
            var memberId: Int
        }
    }
}


extension GameLeaderboardRes {
    func toDomain() -> GameLeaderboardEntity.Res {
        let list = self.contents.map({
            GameLeaderboardEntity.Res.LeaderboardGame(
                score: $0.score ?? 0,
                role: $0.role,
                nickname: $0.nickname,
                rank: $0.rank ?? 0,
                isChangeRecent: $0.isChangeRecent,
                matchCount: $0.matchCount ?? 0,
                userId: $0.userId ?? 0,
                memberId: $0.memberId)
        })
        return GameLeaderboardEntity.Res(
            contents: list
        )
    }
}
