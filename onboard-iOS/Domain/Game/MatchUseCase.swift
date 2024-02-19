//
//  MatchUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/19/24.
//

import Foundation

protocol MatchUseCase {
    func fetchMatch(req: MatchEntity.Req) async throws -> MatchEntity.Res
}
