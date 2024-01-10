//
//  TermsResponse.swift
//  onboard-iOS
//
//  Created by main on 12/28/23.
//

import Foundation

struct TermsResponse: Codable {
    var contents: [Term]
}

struct Term: Codable {
    var isRequired: Bool
    var code: String
    var title: String
    var url: String
}
