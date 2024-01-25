//
//  PlayerReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/18/24.
//

import Foundation

import ReactorKit

final class PlayerReactor: Reactor {
    
    var initialState: State = .init(playerData: [])
    
    enum Action {
        case fetchResult(groupId: Int, size: String)
        case validateNickname(groupId: Int, nickname: String)
    }
    
    enum Mutation {
        case setPlayerData([PlayerEntity.Res])
        case setNicknameResult(GuestNickNameEntity.Res)
    }
    
    struct State {
        var playerData: [PlayerEntity.Res] = []
        var nicknameResult: GuestNickNameEntity.Res?
    }
    
    private let useCase: PlayerUseCase
    
    init(
        useCase: PlayerUseCase
    ) {
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .fetchResult(groupId, size):
            return self.gameListResult(groupId: groupId, size: size)
        case let .validateNickname(groupId, nickname):
            return self.validateResult(groupId: groupId, nickname: nickname)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setPlayerData(let playerData):
            state.playerData = playerData
        case .setNicknameResult(let result):
            state.nicknameResult = result
        }
        
        return state
    }
}

extension PlayerReactor {
    
    private func gameListResult(groupId: Int, size: String) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchPlayerList(groupId: groupId,
                                                                        size: size)
                    observer.onNext(.setPlayerData([result]))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func validateResult(groupId: Int, nickname: String) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchValidateNickName(groupId: groupId,
                                                                              nickname: nickname)
                    observer.onNext(.setNicknameResult(result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
