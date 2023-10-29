//
//  TextFieldLabelState.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/18.
//

import Foundation

struct TextFieldLabelState {
    var isHidden: Bool
    
    var string: String {
        return isHidden ? "임시 멤버가 모임에서 사용할 닉네임을 입력해주세요." : ""
    }
    
    init(isHidden: Bool) {
        self.isHidden = isHidden
    }
}
