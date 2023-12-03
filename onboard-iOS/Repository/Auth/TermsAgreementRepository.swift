//
//  TermsAgreementRepository.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

final class TermsAgreementRepositoryImpl: TermsAgreementRepository {

    func fetch() async throws -> [TermsEntity.Term] {

        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: TermsDTO.self,
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
    
    func agreeTerms(req: TermsAgreementEntity.Req) async throws -> Bool {
        do {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: TermsAgreementDTO.self,
                    router: OBRouter.agreementTerms(
                        body: TermsAgreementRequest.Body(
                            agree: req.agreeList,
                            disagree: req.disagreeList
                        ).encode()
                    )
                )

            guard let data = result.value?.result else {
                throw NetworkError.noExist
            }

            return data

        } catch {
            print(error.localizedDescription)

            throw error
        }
    }
}

extension TermsDTO {
    var toDomain: [TermsEntity.Term] {
        return self.contents.map {
            TermsEntity.Term(
                code: $0.code,
                title: $0.title,
                url: $0.url,
                isReuired: $0.isRequired
            )
        }
    }
}
