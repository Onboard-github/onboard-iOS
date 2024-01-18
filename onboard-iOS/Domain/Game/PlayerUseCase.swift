//
//  PlayerUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/18/24.
//

import Foundation

protocol PlayerUseCase {
    func fetchPlayerList(groupId: Int, size: String) async throws -> PlayerEntity.Res
}
