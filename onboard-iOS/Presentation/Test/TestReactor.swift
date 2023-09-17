//
//  SignUpReactor.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

import ReactorKit

final class TestReactor: Reactor {

    var initialState: State = .init()

    enum Action {
        case testAPI
        case kakao
        case google
        case apple
    }

    enum Mutation {
        case setLoginResult(token: String)
    }

    struct State {
        var result: String = ""
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .testAPI:
            return .empty()

        case .apple:
            // TODO: Apple Login
            return .empty()

        case .google:
            // TODO: Google Login
            return .empty()

        case .kakao:
            // TODO: Kakao Login
            return .empty()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case let .setLoginResult(token):
            state.result = token
        }

        return state
    }
}
