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
    
    // 그룹 아이디
    var groupId: Int?
    
    // 선택한 게임 데이터
    var gameData: GameResultEntity.Res.GameList?
    
    // 임시 멤버 추가에서 입력한 닉네임
    var guestNickNameData: String?
    
    // 기록에서 선택한 플레이어 데이터
    var gamePlayerData: [PlayerEntity.Res.PlayerList] = []
    
    // 기록 날짜 및 시간
    var calendarText = BehaviorRelay<String>(value: "")
    var timeText = BehaviorRelay<String>(value: "")
    
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
    
    // 기록에서 선택한 플레이어 데이터 (추가)
    func addGamePlayer(player: PlayerEntity.Res.PlayerList) {
        self.gamePlayerData.append(player)
    }
    
    // 기록에서 선택한 플레이어 데이터 (제거)
    func removeGamePlayer(at index: Int) {
        guard index < self.gamePlayerData.count else { return }
        self.gamePlayerData.remove(at: index)
    }
    
    // 그룹 아이디 저장하기
    func setGroupId(_ id: Int) {
        groupId = id
    }
    
    // 그룹 아이디 가져오기
    func getGroupId() -> Int? {
        return groupId
    }
}
