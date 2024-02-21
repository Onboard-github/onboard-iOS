//
//  MatchReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/19/24.
//

import Foundation

import ReactorKit

final class MatchReactor: Reactor {
    
    var initialState: State = .init(recordMatchs: nil)
    
    enum Action {
        case recordMatch(req: MatchEntity.Req)
    }
    
    enum Mutation {
        case setMatch(result: MatchEntity.Res)
    }
    
    struct State {
        var recordMatchs: MatchEntity.Res?
    }
    
    private let useCase: MatchUseCase
    
    init(
        useCase: MatchUseCase
    ) {
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .recordMatch(req):
            return self.recordMatchResult(req: req)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case .setMatch(let result):
            state.recordMatchs = result
        }
        
        return state
    }
}

extension MatchReactor {
    
    private func recordMatchResult(req: MatchEntity.Req) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchMatch(req: req)
                    
                    observer.onNext(.setMatch(result: result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
