//
//  GameResultRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/15/24.
//

import Foundation

protocol GameResultRepository {
    func requestResult(groupId: Int, sort: String) async throws -> GameResultEntity.Res
}
