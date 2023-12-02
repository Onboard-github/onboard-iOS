//
//  GroupCreateReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/3/23.
//

import Foundation

import ReactorKit

final class GroupCreateReactor: Reactor {
    
    var initialState: State = .init(imageURL: "")
    
    enum Action {
        case randomImage
    }
    
    enum Mutation {
        case setRandomImage(result: String)
    }
    
    struct State {
        var imageURL: String
    }
    
    private let useCase: GroupCreateUseCase
    
    init(
        useCase: GroupCreateUseCase
    ) {
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .randomImage:
            return self.randomImageResult()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case .setRandomImage(let imageURL):
            state.imageURL = imageURL
        }
        
        return state
    }
}
