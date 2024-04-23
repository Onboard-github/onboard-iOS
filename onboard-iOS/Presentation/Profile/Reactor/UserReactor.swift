//
//  UserReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/23/24.
//

import Foundation

import ReactorKit

final class UserReactor: Reactor {
    
    // MARK: - InitialState
    
    var initialState: State = .init(newNickname: "")
    
    // MARK: - Action
    
    enum Action {
        case updateMe(req: UpdateMyNicknameEntity.Req)
    }
    
    // MARK: - Mutation
    
    enum Mutation {
        case updateMyNickname(result: String)
    }
    
    // MARK: - State
    
    struct State {
        var newNickname: String
    }
    
    // MARK: - Initialize
    
    private let userUseCase: UserUseCase
    
    init(
        userUseCase: UserUseCase
    ) {
        self.userUseCase = userUseCase
    }
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateMe(req):
            return self.updateMeInfo(req: req)
        }
    }
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .updateMyNickname(let result):
            state.newNickname = result
        }
        
        return state
    }
}

extension UserReactor {
    
    private func updateMeInfo(req: UpdateMyNicknameEntity.Req) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.userUseCase.fetchMeInfo(req: req)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
