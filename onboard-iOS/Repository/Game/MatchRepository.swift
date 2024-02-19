//
//  MatchRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/19/24.
//

import Foundation

protocol MatchRepository {
    func requestMatch(req: MatchEntity.Req) async throws -> MatchEntity.Res
}
