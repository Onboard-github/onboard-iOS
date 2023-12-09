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
        case fileUpload(file: File, purpose: Purpose)
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
        case let .fileUpload(file, purpose):
            return self.fileUploadResult(file: file, purpose: purpose)
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

extension GroupCreateReactor {
    
    private func fileUploadResult(file: File, purpose: Purpose) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchFileUpload(file: file, purpose: purpose)
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func randomImageResult() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchRandomImage()
                    
                    observer.onNext(.setRandomImage(result: result.url))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
