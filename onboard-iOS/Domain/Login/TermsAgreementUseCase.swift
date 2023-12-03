//
//  TermsAgreementUseCase.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

import RxSwift

protocol TermsAgreementUseCase {
    var termsList: Observable<[TermsEntity.Term]> { get set }
    var agreeResult: Observable<Bool> { get set }
    func fetch() async
    func agreeTerms(req: TermsAgreementEntity.Req) async
}

protocol TermsAgreementRepository {
    func fetch() async throws -> [TermsEntity.Term]
    func agreeTerms(req: TermsAgreementEntity.Req) async throws -> Bool
}

final class TermsAgreementUseCaseImpl: TermsAgreementUseCase {

    private let repository: TermsAgreementRepository
    
    var termsList: Observable<[TermsEntity.Term]>
    private let _termsList: PublishSubject<[TermsEntity.Term]> = .init()
    
    var agreeResult: Observable<Bool>
    private let _agreeResult: PublishSubject<Bool> = .init()

    init(repository: TermsAgreementRepository) {
        self.repository = repository
        self.termsList = _termsList
        self.agreeResult = _agreeResult
    }

    func fetch() async {
        Task {
            let result = try await self.repository.fetch()
            self._termsList.onNext(result)
        }
    }
    
    func agreeTerms(req: TermsAgreementEntity.Req) async {
        Task {
            let result = try await self.repository.agreeTerms(req: req)
            self._agreeResult.onNext(result)
        }
    }
}
