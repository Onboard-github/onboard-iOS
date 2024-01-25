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
    var guestNickNameData: String?
    
    private let textSubject = PublishSubject<String>()
    
    var textObservable: Observable<String> {
        return textSubject.asObservable()
    }

    private init() {}

    func addSelectedPlayer(_ player: PlayerList) {
        self.playerData.append(player)
    }

    func removePlayer(at index: Int) {
        guard index < self.playerData.count else { return }
        self.playerData.remove(at: index)
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
