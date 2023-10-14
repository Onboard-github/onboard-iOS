//
//  GroupSearchReactor.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import Foundation
import ReactorKit

final class GroupSearchReactor: Reactor {
    var initialState: State = .init()
    
    enum Action {
    }
    
    enum Mutation {
    }

    struct State {
    }

    private let useCase: TestUseCase

    init(useCase: TestUseCase) {
        self.useCase = useCase
    }
}
