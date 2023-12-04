//
//  NicknameReactor.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

import ReactorKit

final class NicknameReactor: Reactor {
    
    var initialState: State = .init()
    
    enum Action {
        case confirm
    }
    
    enum Mutation {
        case setUrl(String)
    }
    
    struct State {
        var token: String = ""
    }
    
    private let coordinator: NicknameCoordinator
    
    init(coordinator: NicknameCoordinator) {
        self.coordinator = coordinator
    }

    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .confirm:
            self.coordinator.showGroupSearch()
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setUrl(url):
            state.token = ""
        }
        
        return state
    }
}
