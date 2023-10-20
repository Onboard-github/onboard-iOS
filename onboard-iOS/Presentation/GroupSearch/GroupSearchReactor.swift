//
//  GroupSearchReactor.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import Foundation
import ReactorKit

final class GroupSearchReactor: Reactor {
    var initialState: State = .init(groupList: [])
    
    enum Action {
        case groupListAllFetch
    }
    
    enum Mutation {
        case setGroupList([GroupEntity.Res.Group])
    }

    struct State {
        var groupList: [GroupEntity.Res.Group]
    }

    private let useCase: GroupSearchUseCase

    init(useCase: GroupSearchUseCase) {
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .groupListAllFetch:
            return self.excuteGroupAllList()
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state

        switch mutation {
        case let .setGroupList(newGroupList):
            state.groupList = newGroupList
        }

        return state
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {

        let loginMutation = self.mutation(
            result: self.useCase.groupList
        )

        return Observable.merge(mutation, loginMutation)
    }
}

extension GroupSearchReactor {
    private func mutation(result: Observable<[GroupEntity.Res.Group]>) -> Observable<Mutation> {
        return result.flatMap { response -> Observable<Mutation> in
            return .just(.setGroupList(response))
        }
    }
    
    private func excuteGroupAllList() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            Task {
                do {
                    await self.useCase.list(keyword: nil, pageNumber: 0, pageSize: 10)
                }
            }
            return Disposables.create()
        }
    }
}
