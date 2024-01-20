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
    
    private init() {}
}

struct PlayerList {
    let image: UIImage
    let title: String
}
