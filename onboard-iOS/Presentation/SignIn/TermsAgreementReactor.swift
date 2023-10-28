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
    
}
