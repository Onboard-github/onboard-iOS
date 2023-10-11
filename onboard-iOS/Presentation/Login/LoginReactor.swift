//
//  LoginReactor.swift
//  onboard-iOS
//
//  Created by Daye on 2023/10/08.
//

import Foundation

import ReactorKit

final class LoginReactor: Reactor {

    var initialState: State = .init()

    enum Action {
        case apple
        case google
        case kakao
    }

    enum Mutation {
        case setLoginResult(result: String)
    }

    struct State {
        var result: String = ""
    }
    
    private let appleUseCase: AppleLoginUseCase
    private let kakaoUseCase: KakaoLoginUseCase

    init(
        appleUseCase: AppleLoginUseCase,
        kakaoUseCase: KakaoLoginUseCase
    ) {
        self.appleUseCase = appleUseCase
        self.kakaoUseCase = kakaoUseCase
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .apple:
            return self.excuteAppleLogin()

        case .google:
            return self.googleLoginResult()

        case .kakao:
            // TODO: Kakao Login
            return self.excuteKakaoLogin()
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

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {

        let loginMutation = self.mutation(
            result: self.appleUseCase.result
        )

        return Observable.merge(mutation, loginMutation)
    }

}

extension LoginReactor {

    private func mutation(result: Observable<Bool>) -> Observable<Mutation> {
        return result.flatMap { response -> Observable<Mutation> in
            if response {
                return .just(.setLoginResult(result: "success"))
            }
            return .just(.setLoginResult(result: "fail"))
        }
    }

    private func excuteAppleLogin() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }

            Task {
                do {
                    await self.appleUseCase.signIn()
                }
            }
            return Disposables.create()
        }
    }

    private func excuteKakaoLogin() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            Task {
                do {
                    await self.kakaoUseCase.signIn()
                }
            }
            return Disposables.create()
        }
    }

    private func googleLoginResult() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }

//            GoogleLoginManager.shared.signIn(withPresenting: uiViewController)

            return Disposables.create()
        }
    }
}
