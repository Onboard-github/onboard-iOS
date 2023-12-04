//
//  TermsAgreementReactor.swift
//  onboard-iOS
//
//  Created by 윤다예 on 10/28/23.
//

import Foundation

import ReactorKit

final class TermsAgreementReactor: Reactor {
    
    var initialState: State = .init()
    
    enum Action {
        case viewDidLoad
        case selectDetail(IndexPath)
        case selectCheck(indexPath: IndexPath)
        case selectAllAgreement
        case selectRegister
    }
    
    enum Mutation {
        case setTerms([State.Term])
        case updateCheckStatus(indexPath: IndexPath)
        case updateAllAgreement
    }
    
    struct State {
        var terms: [Term] = []
        var isAllAgreemented: Bool = false
        
        struct Term {
            let title: String
            let isRequired: Bool
            let url: String
            let isChecked: Bool
        }
    }
    
    private let coordinator: TermsAgreementCoordinator
    private let useCase: TermsAgreementUseCase
    
    init(
        coordinator: TermsAgreementCoordinator,
        useCase: TermsAgreementUseCase
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return self.fetch()
            
        case let .selectDetail(indexPath):
            let url = self.currentState.terms[indexPath.row].url
            
            self.coordinator.showTerms(url: url)
            
            return .empty()
            
        case let .selectCheck(indexPath):
            return .just(.updateCheckStatus(indexPath: indexPath))
            
        case .selectAllAgreement:
            return .just(.updateAllAgreement)
            
        case .selectRegister:
            self.coordinator.showNicknameSetting()
            
            return .empty()
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setTerms(terms):
            state.terms = terms
            
        case let .updateCheckStatus(indexPath):
            state = self.updateAgreementStatus(
                terms: state.terms,
                indexPath: indexPath
            )
            
        case .updateAllAgreement:
            state = self.updateAllAgreementStatus(state: state)
        }
        
        return state
        
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {

        let loginMutation = self.mutation(
            result: self.useCase.result
        )

        return Observable.merge(mutation, loginMutation)
    }
    
}

extension TermsAgreementReactor {
    
    private func mutation(
        result: Observable<[TermsAgreementEntity.Term]>
    ) -> Observable<Mutation> {
        return result.flatMap { response -> Observable<Mutation> in
            return .just(.setTerms(self.toState(response)))
        }
    }
    
    private func fetch() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            Task {
                do {
                    await self.useCase.fetch()
                }
            }
            return Disposables.create()
        }
    }
    
    private func toState(
        _ terms: [TermsAgreementEntity.Term]
    ) -> [TermsAgreementReactor.State.Term] {
        return terms.map { TermsAgreementReactor.State.Term(
            title: $0.title,
            isRequired: $0.isReuired,
            url: $0.url,
            isChecked: false
        )}
    }
    
    private func updateAgreementStatus(
        terms: [State.Term],
        indexPath: IndexPath
    ) -> State {
        var terms = terms
        
        let term = terms[indexPath.item]
        
        terms[indexPath.item] = State.Term(
            title: term.title,
            isRequired: term.isRequired,
            url: term.url,
            isChecked: !term.isChecked
        )
        
        let isAllAgreement = !terms.contains(where: { $0.isChecked == false })
        
        return State(terms: terms, isAllAgreemented: isAllAgreement)
    }
    
    private func updateAllAgreementStatus(state: State) -> State {
        var terms = state.terms
        
        return State(
            terms: terms.map {
                State.Term(
                    title: $0.title,
                    isRequired: $0.isRequired,
                    url: $0.url,
                    isChecked: !state.isAllAgreemented
                )
            },
            isAllAgreemented: !state.isAllAgreemented
        )
    }
}
