//
//  PopupState.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/14.
//

import Foundation

struct PopupState {
    let titleLabel: String
    let subTitleLabel: String
    let textFieldPlaceholder: String
    let textFieldSubTitleLabel: String
    let countLabel: String
    let buttonLabel: String
    var linkButtonState: LinkButtonState?
    var textFieldLabelState: TextFieldLabelState?
}
