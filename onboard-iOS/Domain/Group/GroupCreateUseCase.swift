//
//  GroupCreateUseCase.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

protocol GroupCreateUseCase {
    func fetchRandomImage() async throws -> GroupCreateEntity
}
