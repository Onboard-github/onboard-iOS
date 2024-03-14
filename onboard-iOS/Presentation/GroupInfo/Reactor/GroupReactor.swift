//
//  GroupReactor.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

import ReactorKit

final class GroupReactor: Reactor {
    
    // MARK: - InitialState
    
    var initialState: State = .init(groupInfoData: nil)
    
    // MARK: - Action
    
    enum Action {
        case fetchResult(groupId: Int)
        case allPlayerData(groupId: Int, gameId: Int)
        case assginOwner(groupId: Int, memberId: Int)
        case groupDelete(groupId: Int)
        case memberUnsubscribe(groupId: Int)
        case getMatchCount(groupId: Int, memberId: Int)
    }
    
    // MARK: - Mutation
    
    enum Mutation {
        case setGroupInfo(GroupInfoEntity.Res)
        case setAllPlayerData([GameLeaderboardEntity.Res])
        case setOwner(result: MemberEntity.Res)
        case setMemberUnsubscribe(result: MemberEntity.Res)
        case setMatchCount(result: MemberEntity.MatchCountRes)
    }
    
    // MARK: - State
    
    struct State {
        var groupInfoData: GroupInfoEntity.Res?
        var allPlayer: [GameLeaderboardEntity.Res] = []
        var assginOwnerResult: MemberEntity.Res?
        var memberUnsubscribeResult: MemberEntity.Res?
        var memberMatchCount: MemberEntity.MatchCountRes?
    }
    
    // MARK: - Initialize
    
    private let useCase: GroupUseCase
    private let playerUseCase: PlayerUseCase
    private let memberUseCase: MemberUseCase
    
    init(
        useCase: GroupUseCase,
        playerUseCase: PlayerUseCase,
        memberUseCase: MemberUseCase
    ) {
        self.useCase = useCase
        self.playerUseCase = playerUseCase
        self.memberUseCase = memberUseCase
    }
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .fetchResult(groupId):
            return self.groupInfoResult(groupId: groupId)
        case let .allPlayerData(groupId, gameId):
            return self.updatePlayerResult(groupId: groupId, gameId: gameId)
        case let .assginOwner(groupId, memberId):
            return self.assignOwnerResult(groupId: groupId, memberId: memberId)
        case let .groupDelete(groupId):
            return self.groupDeleteResult(groupId: groupId)
        case let .memberUnsubscribe(groupId):
            return self.memberUnsubscribeResult(groupId: groupId)
        case let .getMatchCount(groupId, memberId):
            return self.matchCountResult(groupId: groupId, memberId: memberId)
        }
    }
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setGroupInfo(let result):
            state.groupInfoData = result
        case .setAllPlayerData(let result):
            state.allPlayer = result
        case .setOwner(let result):
            state.assginOwnerResult = result
        case .setMemberUnsubscribe(let result):
            state.memberUnsubscribeResult = result
        case .setMatchCount(let result):
            state.memberMatchCount = result
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
    
    private func updatePlayerResult(groupId: Int, gameId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.playerUseCase.fetchAllPlayer(groupId: groupId,
                                                                             gameId: gameId)
                    observer.onNext(.setAllPlayerData([result]))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func assignOwnerResult(groupId: Int, memberId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.memberUseCase.fetchAssignOwner(groupId: groupId, memberId: memberId)
                    
                    observer.onNext(.setOwner(result: result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func groupDeleteResult(groupId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    try await self.useCase.fetchGroupDelete(groupId: groupId)
                    
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func memberUnsubscribeResult(groupId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    try await self.memberUseCase.fetchMemberUnsubscribe(groupId: groupId)
                    
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func matchCountResult(groupId: Int, memberId: Int) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            
            Task {
                do {
                    let result = try await self.memberUseCase.fetchMatchCount(groupId: groupId, memberId: memberId)
                    observer.onNext(.setMatchCount(result: result))
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
