//
//  PlayerRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/18/24.
//

import Foundation

protocol PlayerRepository {
    func requestPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res
}
