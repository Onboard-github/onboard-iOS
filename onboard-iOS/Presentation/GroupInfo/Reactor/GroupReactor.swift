//
//  GroupReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

import ReactorKit

final class GroupReactor: Reactor {
    
    var initialState: State = .init(groupInfoData: nil)
    
    enum Action {
        case fetchResult(groupId: Int)
        case allPlayerData(groupId: Int, gameId: Int)
    }
    
    enum Mutation {
        case setGroupInfo(GroupInfoEntity.Res)
        case setAllPlayerData([GameLeaderboardEntity.Res])
    }
    
    struct State {
        var groupInfoData: GroupInfoEntity.Res?
        var allPlayer: [GameLeaderboardEntity.Res] = []
    }
    
    private let useCase: GroupUseCase
    private let playerUseCase: PlayerUseCase
    
    init(
        useCase: GroupUseCase,
        playerUseCase: PlayerUseCase
    ) {
        self.useCase = useCase
        self.playerUseCase = playerUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .fetchResult(groupId):
            return self.groupInfoResult(groupId: groupId)
        case let .allPlayerData(groupId, gameId):
            return self.updatePlayerResult(groupId: groupId, gameId: gameId)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setGroupInfo(let result):
            state.groupInfoData = result
        case .setAllPlayerData(let result):
            state.allPlayer = result
        }
        
        return state
    }
}

extension GroupReactor {
    
    private func groupInfoResult(groupId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchInfo(groupId: groupId)
                    observer.onNext(.setGroupInfo(result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func updatePlayerResult(groupId: Int, gameId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.playerUseCase.fetchAllPlayer(groupId: groupId,
                                                                             gameId: gameId)
                    observer.onNext(.setAllPlayerData([result]))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}

