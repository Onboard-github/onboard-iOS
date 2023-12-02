//
//  TermsAgreementUseCase.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

import RxSwift

protocol TermsAgreementUseCase {
    var result: Observable<[TermsAgreementEntity.Term]> { get set }
    func fetch() async
}

protocol TermsAgreementRepository {
    func fetch() async throws -> [TermsAgreementEntity.Term]
}

final class TermsAgreementUseCaseImpl: TermsAgreementUseCase {

    private let repository: TermsAgreementRepository
    
    var result: Observable<[TermsAgreementEntity.Term]>
    private let _result: PublishSubject<[TermsAgreementEntity.Term]> = .init()

    init(repository: TermsAgreementRepository) {
        self.repository = repository
        self.result = _result
    }

    func fetch() async {
        Task {
            let result = try await self.repository.fetch()
            self._result.onNext(result)
        }
    }
}
