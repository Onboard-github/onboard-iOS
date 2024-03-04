//
//  SettingOptions.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import Foundation

enum SettingOptions: Int, CaseIterable {
//    case modify
//    case accessChange
//    case manage
    case manageChange
    case delete
    
    var settings: String {
        switch self {
//        case .modify:
//            return "모임 정보 수정"
//        case .accessChange:
//            return "참여코드 변경"
//        case .manage:
//            return "멤버 관리"
        case .manageChange:
            return "관리자 변경"
        case .delete:
            return "모임 삭제"
        }
    }
}
