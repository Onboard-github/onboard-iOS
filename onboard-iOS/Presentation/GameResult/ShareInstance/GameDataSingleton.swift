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
    
    // 임시 멤버 닉네임 추가
    func addGuestNickName(_ text: String) {
        self.guestNickNameData = text
        textSubject.onNext(text)
    }
    
    // 임시 멤버 추가
    func addPlayer(_ player: PlayerList) {
        self.playerData.append(player)
    }
    
    // 플레이어 선택
    func addSelectedPlayer(_ player: PlayerList) {
        self.selectedPlayerData.append(player)
    }
    
    func removePlayer(at index: Int) {
        guard index < self.selectedPlayerData.count else { return }
        self.selectedPlayerData.remove(at: index)
    }
    
    // 선택한 플레이어 제거
    func removeSelectedPlayer(_ player: PlayerList) {
        if let index = self.selectedPlayerData.firstIndex(where: { $0.title == player.title }) {
            self.selectedPlayerData.remove(at: index)
        }
    }
}

struct PlayerList: Equatable {
    let image: UIImage
    let title: String
    var score: String?
    
    static func == (lhs: PlayerList, rhs: PlayerList) -> Bool {
        return lhs.image == rhs.image && lhs.title == rhs.title
    }
}
