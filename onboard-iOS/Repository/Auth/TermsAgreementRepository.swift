//
//  TermsAgreementRepository.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

final class TermsAgreementRepositoryImpl: TermsAgreementRepository {

    func fetch() async throws -> [TermsAgreementEntity.Term] {

        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: TermsAgreementDTO.self,
                    router: OBRouter.terms
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

extension TermsAgreementDTO {
    var toDomain: [TermsAgreementEntity.Term] {
        return self.contents.map {
            TermsAgreementEntity.Term(
                code: $0.code,
                title: $0.title,
                url: $0.url,
                isReuired: $0.isRequired
            )
        }
    }
}
