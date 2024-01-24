//
//  GuestNicknameDTO.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/24/24.
//

import Foundation

struct GuestNicknameDTO: Decodable {
    let isAvailable: Bool
    let reason: String
}
