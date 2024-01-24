//
//  GuestReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/24/24.
//

import Foundation

import ReactorKit

final class GuestReactor: Reactor {
    
    var initialState: State = .init(nicknameResult: .init(isAvailable: false, reason: ""))
    
    enum Action {
        case validateNickname(groupId: Int, nickname: String)
    }
    
    enum Mutation {
        case setNicknameResult(GuestNickNameEntity.Res)
    }
    
    struct State {
        var nicknameResult: GuestNickNameEntity.Res
    }
    
    private let useCase: GuestUseCase
    
    init(
        useCase: GuestUseCase
    ) {
        self.useCase = useCase
    }
    
    // MARK: - Methods
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .validateNickname(groupId, nickname):
            return self.validateResult(groupId: groupId, nickname: nickname)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case .setNicknameResult(let result):
            state.nicknameResult = result
        }
        
        return state
    }
}

extension GuestReactor {
    
    private func validateResult(groupId: Int, nickname: String) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchValidateNickName(groupId: groupId,
                                                                              nickname: nickname)
                    observer.onNext(.setNicknameResult(result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
