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
        case confirm
    }
    
    enum Mutation {
        case setTerms([State.Term])
        case goDetail(url: String)
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
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return self.fetch()
            
        case let .selectDetail(indexPath):
            return .empty()
            
        case let .selectCheck(indexPath):
            return .just(.updateCheckStatus(indexPath: indexPath))
            
        case .selectAllAgreement:
            return .just(.updateAllAgreement)
            
        case .confirm:
            return .empty()
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setTerms(terms):
            state.terms = terms
            
        case let .updateCheckStatus(indexPath):
            state.terms = self.updateAgreementStatus(
                terms: state.terms,
                indexPath: indexPath
            )
            
        case .updateAllAgreement:
            state = self.updateAllAgreementStatus(state: state)
            
        default:
            print("no reduce yet")
        }
        
        return state
        
    }
    
}

extension TermsAgreementReactor {
    
    private func fetch() -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            
            // TODO: - Mock data, domain + repo layer 작업 이후 변경
            
            observer.onNext(.setTerms([
                .init(
                    title: "서비스 이용약관",
                    isRequired: true,
                    url: "https://www.naver.com",
                    isChecked: false
                ),
                .init(
                    title: "개인정보 처리방침",
                    isRequired: true,
                    url: "https://www.google.com",
                    isChecked: false
                )
            ]))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    private func updateAgreementStatus(
        terms: [State.Term],
        indexPath: IndexPath
    ) -> [State.Term] {
        var terms = terms
        
        let term = terms[indexPath.item]
        
        terms[indexPath.item] = State.Term(
            title: term.title,
            isRequired: term.isRequired,
            url: term.url,
            isChecked: !term.isChecked
        )
        
        return terms
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
