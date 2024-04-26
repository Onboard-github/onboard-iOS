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
        case validateNickname(groupId: Int, nickname: String)
        case myGroupInfoData(groupId: Int)
    }
    
    // MARK: - Mutation
    
    enum Mutation {
        case updateMyNickname(result: String)
        case setValidateNickname(GuestNickNameEntity.Res)
        case setGroupData(GroupInfoEntity.Res)
    }
    
    // MARK: - State
    
    struct State {
        var newNickname: String
        var nicknameResult: GuestNickNameEntity.Res?
        var groupInfoData: GroupInfoEntity.Res?
    }
    
    // MARK: - Initialize
    
    private let userUseCase: UserUseCase
    private let playerUseCase: PlayerUseCase
    private let groupUseCase: GroupUseCase
    
    init(
        userUseCase: UserUseCase,
        playerUseCase: PlayerUseCase,
        groupUseCase: GroupUseCase
    ) {
        self.userUseCase = userUseCase
        self.playerUseCase = playerUseCase
        self.groupUseCase = groupUseCase
    }
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateMe(req):
            return self.updateMeInfo(req: req)
        case let .validateNickname(groupId, nickname):
            return self.validateResult(groupId: groupId, nickname: nickname)
        case let .myGroupInfoData(groupId):
            return self.groupInfoResult(groupId: groupId)
        }
    }
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .updateMyNickname(let result):
            state.newNickname = result
        case .setValidateNickname(let result):
            state.nicknameResult = result
        case .setGroupData(let result):
            state.groupInfoData = result
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
    
    private func validateResult(groupId: Int, nickname: String) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.playerUseCase.fetchValidateNickName(groupId: groupId,
                                                                                    nickname: nickname)
                    observer.onNext(.setValidateNickname(result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func groupInfoResult(groupId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.groupUseCase.fetchInfo(groupId: groupId)
                    observer.onNext(.setGroupData(result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
