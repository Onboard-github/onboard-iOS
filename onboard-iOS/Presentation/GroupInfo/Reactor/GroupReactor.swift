//
//  GroupReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

import ReactorKit

final class GroupReactor: Reactor {
    
    var initialState: State = .init(groupInfoData: nil)
    
    enum Action {
        case fetchResult(groupId: Int)
    }
    
    enum Mutation {
        case setGroupInfo(GroupInfoEntity.Res)
    }
    
    struct State {
        var groupInfoData: GroupInfoEntity.Res?
    }
    
    private let useCase: GroupUseCase
    
    init(
        useCase: GroupUseCase
    ) {
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .fetchResult(groupId):
            return self.groupInfoResult(groupId: groupId)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setGroupInfo(let result):
            state.groupInfoData = result
        }
        
        return state
    }
}

extension GroupReactor {
    
    private func groupInfoResult(groupId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchInfo(groupId: groupId)
                    observer.onNext(.setGroupInfo(result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
        
    }
}

