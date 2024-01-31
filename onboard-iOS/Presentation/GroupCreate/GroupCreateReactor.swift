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
        case createGroups(req: GroupCreateCompleteEntity.Req)
    }
    
    enum Mutation {
        case setRandomImage(result: String)
        case setGroupCreation(result: GroupCreateCompleteEntity.Res)
    }
    
    struct State {
        var imageURL: String
        var createdGroup: GroupCreateCompleteEntity.Res?
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
        case let .createGroups(req):
            return self.createGroupResult(req: req)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
        var state = state
        
        switch mutation {
        case .setRandomImage(let imageURL):
            state.imageURL = imageURL
        case .setGroupCreation(let result):
            state.createdGroup = result
        }
        
        return state
    }
    
    //    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    //        let groupMutation = self.mutation(
    //            result: self.useCase.createGroupResult)
    //        return Observable.merge(mutation, groupMutation)
    //    }
}

extension GroupCreateReactor {
    
    //    private func mutation(result: Observable<GroupCreateCompleteEntity.Res>) -> Observable<Mutation> {
    //        return result.flatMap { response -> Observable<Mutation> in
    //            return .just(.setGroupCreation(result: response))
    //        }
    //    }
    
    private func fileUploadResult(file: File, purpose: Purpose) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchFileUpload(file: file, purpose: purpose)
                    
                    DispatchQueue.main.async {
                        let url = result.url
                        let uuid = result.uuid
                        GroupCreateSingleton.shared.groupImageUrl.accept(url)
                        GroupCreateSingleton.shared.groupImageUrl.accept(uuid)
                    }
                    
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func randomImageResult() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.fetchRandomImage()
                    
                    DispatchQueue.main.async {
                        let url = result.url
                        let uuid = result.uuid
                        GroupCreateSingleton.shared.groupImageUrl.accept(url)
                        GroupCreateSingleton.shared.groupImageUrl.accept(uuid)
                    }
                    
                    observer.onNext(.setRandomImage(result: result.url))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func createGroupResult(req: GroupCreateCompleteEntity.Req) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.useCase.createGroup(req: req)
                    observer.onNext(.setGroupCreation(result: result))
                    
                    DispatchQueue.main.async {
                        GroupCreateSingleton.shared.accessCodeText.accept(result.accessCode)
                    }
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
