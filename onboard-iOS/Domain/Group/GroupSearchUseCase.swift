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
    func list() async
}

protocol GroupRepository {
    func list() async throws -> GroupEntity.Res
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

    func list() async {
        Task {
            let groupList = try await self.groupRepository.list()
            self._groupList.onNext(groupList.contents)
        }
    }
}
