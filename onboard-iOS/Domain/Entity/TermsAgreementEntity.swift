//
//  TermsAgreementEntity.swift
//  onboard-iOS
//
//  Created by 윤다예 on 11/28/23.
//

import Foundation

struct TermsAgreementEntity {
    let terms: [Term]
    
    struct Term {
        let code: String
        let title: String
        let url: String
        let isReuired: Bool
    }
}
