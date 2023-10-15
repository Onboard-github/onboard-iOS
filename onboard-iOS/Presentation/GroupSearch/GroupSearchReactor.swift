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
}
