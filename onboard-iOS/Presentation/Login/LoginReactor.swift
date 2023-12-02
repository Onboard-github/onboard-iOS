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

    struct State {
        var result: String = ""
        var stage: [OnboardingStage] = []
    }
    
    private let coordinator: LoginCoordinator
    private let appleUseCase: AppleLoginUseCase
    private let kakaoUseCase: KakaoLoginUseCase

    init(
        appleUseCase: AppleLoginUseCase,
        kakaoUseCase: KakaoLoginUseCase,
        coordinator: LoginCoordinator
    ) {
        self.appleUseCase = appleUseCase
        self.kakaoUseCase = kakaoUseCase
        self.coordinator = coordinator
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .apple:
            return self.excuteAppleLogin()

        case .google:
            return self.googleLoginResult()

        case .kakao:
            return self.excuteKakaoLogin()
        }
    }
}

extension LoginReactor {

    private func mutation(result: Observable<OnboardingEntity>) -> Observable<Mutation> {
        return result.flatMap { response -> Observable<Mutation> in
            
            guard let firstStage = response.stages.first,
                  let stage = OnboardingStage(rawValue: firstStage) else {
                
                // TODO: - 온보딩 남은 스테이지 없음 -> home으로 이동
//                if response.stages.isEmpty {
//                    return self.coordinator.showHome()
//                }
                return .empty()
            }
            
            switch stage {
            case .terms, .updateTerms:
                DispatchQueue.main.async {
                    self.coordinator.showTermsAgreementView()
                }
            case .nickname:
                DispatchQueue.main.async {
                    self.coordinator.showNicknameSetting()
                }
            case .joinGroup:
                // TODO: - group 설정 페이지 이동
                break
            }
            
            return .empty()
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

            self.coordinator.showTermsAgreementView()

            return Disposables.create()
        }
    }
}
