//
//  GuestRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/24/24.
//

import Foundation

protocol GuestRepository {
    func requestValidateNickName(groupId: Int, nickname: String) async throws -> GuestNickNameEntity.Res
}
