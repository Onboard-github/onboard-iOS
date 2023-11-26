//
//  TermsReactor.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/26/23.
//

import Foundation

import ReactorKit

final class TermsReactor: Reactor {
    
    var initialState: State = .init()
    
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case setUrl(String)
    }
    
    struct State {
        var url: String = ""
    }
    
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return .just(.setUrl(self.url))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setUrl(url):
            state.url = url
        }
        
        return state
    }
}
