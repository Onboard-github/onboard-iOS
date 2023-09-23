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

    private let useCase: TestUseCase
    private let appleUseCase: AppleLoginUseCase

    init(
        useCase: TestUseCase,
        appleUseCase: AppleLoginUseCase
    ) {
        self.useCase = useCase
        self.appleUseCase = appleUseCase
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .testAPI:
            return self.fetchTestResult()

        case .apple:
            return self.excuteAppleLogin()

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

extension TestReactor {

    private func excuteAppleLogin() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }

            Task {
                do {
                    let result = await self.appleUseCase.signIn()

                    if result {
                        observer.onNext(.setLoginResult(token: "success"))
                        observer.onCompleted()
                    }
                } 
            }
            return Disposables.create()
        }
    }

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
}
