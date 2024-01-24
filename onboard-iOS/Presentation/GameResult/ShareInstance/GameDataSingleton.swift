//
//  GameDataSingleton.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/19/24.
//

import Foundation

import UIKit

class GameDataSingleton {
    
    static let shared = GameDataSingleton()

    var gameData: GameResultEntity.Res.GameList?
    var playerData: [PlayerList] = []

    private init() {}

    func addSelectedPlayer(_ player: PlayerList) {
        self.playerData.append(player)
    }

    func removePlayer(at index: Int) {
        guard index < self.playerData.count else { return }
        self.playerData.remove(at: index)
    }
}

struct PlayerList {
    let image: UIImage
    let title: String
}
