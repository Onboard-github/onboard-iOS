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
        case selectCheck(IndexPath)
        case confirm
    }
    
    enum Mutation {
        case setTerms([State.Term])
        case goDetail(url: String)
        case updateCheckStatus
    }
    
    struct State {
        var terms: [Term] = []
        
        struct Term {
            let title: String
            let isRequired: Bool
            let url: String
        }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
        switch action {
        case .viewDidLoad:
            return self.fetch()
            
        case let .selectDetail(indexPath):
            return .empty()
            
        case let .selectCheck(indexPath):
            return .empty()
            
        case .confirm:
            return .empty()
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setTerms(terms):
            state.terms = terms
            
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
                .init(title: "서비스 이용약관", isRequired: true, url: "https://www.naver.com"),
                .init(title: "개인정보 처리방침", isRequired: true, url: "https://www.google.com")
            ]))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
