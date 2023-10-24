//
//  LinkButtonState.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/14.
//

import Foundation

struct LinkButtonState {
    var isLink: Bool

    var string: String {
        return isLink ? "임시 멤버 연동" : ""
    }

    init(isLink: Bool) {
        self.isLink = isLink
    }
}
