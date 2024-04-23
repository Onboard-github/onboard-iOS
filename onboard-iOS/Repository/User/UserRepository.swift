//
//  UserRepository.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/23/24.
//

import Foundation

protocol UserRepository {
    func requestMeInfo(req: UpdateMyNicknameEntity.Req) async throws -> UpdateMyNicknameEntity.Res
}
