//
//  GameResultUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/15/24.
//

import Foundation

protocol GameResultUseCase {
    func fetchResult(groupId: Int, sort: String) async throws -> GameResultEntity.Res
}
