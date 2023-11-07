//
//  GroupRepository.swift
//  onboard-iOS
//
//  Created by main on 2023/10/15.
//

import Foundation

final class GroupRepositoryImpl: GroupRepository {
    func list(keyword: String? = nil, pageNumber: Int = 0, pageSize: Int = 10) async throws -> GroupEntity.Res {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GroupDTO.self,
                    router: OBRouter.groupList(params: ["keyword": keyword ?? "", "pageNumber": "\(pageNumber)", "pageSize": "\(pageSize)"])
                )

            guard let data = result.value else {
                throw NetworkError.noExist
            }

            return data.toDomain

        } catch {
            print(error.localizedDescription)

            throw error
        }
    }
}

extension GroupDTO {
    var toDomain: GroupEntity.Res {
        let groupList = self.content.map({GroupEntity.Res.Group(id: $0.id, name: $0.name, description: $0.description, organization: $0.organization, profileImageUrl: $0.profileImageUrl)})
        return GroupEntity.Res(contents: groupList)
    }
}
