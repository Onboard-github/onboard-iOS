//
//  GameDataSingleton.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/19/24.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class GameDataSingleton {
    
    static let shared = GameDataSingleton()
    
    var gameData: GameResultEntity.Res.GameList?
    var playerData: [PlayerList] = []
    var selectedPlayerData: [PlayerList] = []
    var guestNickNameData: String?
    
    private let textSubject = PublishSubject<String>()
    
    var textObservable: Observable<String> {
        return textSubject.asObservable()
    }
    
    // MARK: - Initialize
    
    private init() {}
    
    // MARK: - Func
    
    func addPlayer(_ player: PlayerList) {
        self.playerData.append(player)
    }
    
    func addSelectedPlayer(_ player: PlayerList) {
        self.selectedPlayerData.append(player)
    }
    
    func removePlayer(at index: Int) {
        guard index < self.selectedPlayerData.count else { return }
        self.selectedPlayerData.remove(at: index)
    }
    
    func addGuestNickName(_ text: String) {
        self.guestNickNameData = text
        textSubject.onNext(text)
    }
}

struct PlayerList {
    let image: UIImage
    let title: String
}
