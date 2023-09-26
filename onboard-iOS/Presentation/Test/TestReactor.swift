//
//  SignUpReactor.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import UIKit
import Foundation

import ReactorKit


final class TestReactor: Reactor {

    var initialState: State = .init()
    
    struct Action {
        
        let action: ActionType
        let uiViewController: UIViewController
        
        init(action: ActionType, uiViewController: UIViewController) {
            self.action = action
            self.uiViewController = uiViewController
        }
    }

    enum ActionType {
        case testAPI
        case apple
        case google
        case kakao
    }

    enum Mutation {
        case setLoginResult(token: String)
    }

    struct State {
        var result: String = ""
    }

    private let useCase: TestUseCase

    init(useCase: TestUseCase) {
        self.useCase = useCase
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action.action {
        case .testAPI:
            return self.fetchTestResult()

        case .apple:
            // TODO: Apple Login
            return .empty()

        case .google:
            return self.googleLoginResult(uiViewController: action.uiViewController)

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

extension TestReactor {

    private func fetchTestResult() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }

            Task {
                do {
                    let result = try await self.useCase.fetchTestAPi()

                    observer.onNext(.setLoginResult(token: result.text))
                    observer.onCompleted()

                } catch {
                    throw error
                }
            }
            return Disposables.create()
        }
    }
    
    private func googleLoginResult(uiViewController: UIViewController) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            
            GoogleLoginManager.shared.signIn(withPresenting: uiViewController)
            
            return Disposables.create()
        }
    }
}
