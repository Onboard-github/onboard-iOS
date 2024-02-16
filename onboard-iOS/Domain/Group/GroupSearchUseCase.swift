//
//  GroupSearchUseCase.swift
//  onboard-iOS
//
//  Created by main on 2023/10/15.
//

import Foundation
import RxSwift

protocol GroupSearchUseCase {
    var groupList: Observable<[GroupEntity.Res.Group]> { get }
    func list(keyword: String?, pageNumber: Int, pageSize: Int) async
}

protocol GroupUseCase {
    func fetchInfo(groupId: Int) async throws -> GroupInfoEntity.Res
}

protocol GroupRepository {
    func list(keyword: String?, pageNumber: Int, pageSize: Int) async throws -> GroupEntity.Res
    func requestInfo(groupId: Int) async throws -> GroupInfoEntity.Res
}

final class GroupSearchUseCaseImpl: GroupSearchUseCase {

    private let groupRepository: GroupRepository

    var groupList: Observable<[GroupEntity.Res.Group]>
    private let _groupList: PublishSubject<[GroupEntity.Res.Group]> = .init()
    
    init(
        groupRepository: GroupRepository
    ) {
        self.groupRepository = groupRepository
        self.groupList = self._groupList
    }

    func list(keyword: String?, pageNumber: Int, pageSize: Int) async {
        Task {
            let groupList = try await self.groupRepository.list(keyword: keyword, pageNumber: pageNumber, pageSize: pageSize)
            self._groupList.onNext(groupList.contents)
        }
    }
}

final class GroupUseCaseImpl: GroupUseCase {
    
    private let repository: GroupRepository
    
    init(repository: GroupRepository) {
        self.repository = repository
    }
    
    func fetchInfo(groupId: Int) async throws -> GroupInfoEntity.Res {
        try await self.repository.requestInfo(groupId: groupId)
    }
}
