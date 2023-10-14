//
//  PopupState.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/14.
//

import Foundation

class PopupState {
    let titleLabel: String
    let subTitleLabel: String
    let textFieldPlaceholder: String
    let textFieldSubTitleLabel: String
    let countLabel: String
    let buttonLabel: String
    var linkButtonState: LinkButtonState?
    
    init(titleLabel: String,
         subTitleLabel: String,
         textFieldPlaceholder: String,
         textFieldSubTitleLabel: String,
         countLabel: String,
         buttonLabel: String,
         linkButtonState: LinkButtonState?) {
        
        self.titleLabel = titleLabel
        self.subTitleLabel = subTitleLabel
        self.textFieldPlaceholder = textFieldPlaceholder
        self.textFieldSubTitleLabel = textFieldSubTitleLabel
        self.countLabel = countLabel
        self.buttonLabel = buttonLabel
        self.linkButtonState = linkButtonState
    }
}
