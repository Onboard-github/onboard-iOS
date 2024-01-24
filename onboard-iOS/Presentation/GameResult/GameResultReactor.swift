//
//  GameResultReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/15/24.
//

import Foundation

import ReactorKit

final class GameResultReactor: Reactor {
    
    var initialState: State = .init(gameData: [])
    
    enum Action {
        case fetchResult(groupId: Int, sort: String)
    }
    
    enum Mutation {
        case setGameData([GameResultEntity.Res])
    }
    
    struct State {
        var gameData: [GameResultEntity.Res] = []
    }
    
    private let useCase: GameResultUseCase
    
    init(
        useCase: GameResultUseCase
    ) {
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .fetchResult(groupId, sort):
            return self.gameListResult(groupId: groupId, sort: sort)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setGameData(let gameData):
            state.gameData = gameData
        }
        
        return state
    }
}

extension GameResultReactor {
    
    private func gameListResult(groupId: Int, sort: String) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchResult(groupId: groupId, sort: sort)
                    observer.onNext(.setGameData([result]))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
