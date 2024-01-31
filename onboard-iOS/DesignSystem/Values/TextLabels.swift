//
//  TextLabels.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/2/23.
//

import Foundation

struct TextLabels {
    
    // MARK: - Group Create
    
    static let group_name = "그룹 이름"
    static let group_name_placeholder = "그룹 이름을 입력해주세요."
    static let group_name_count = "00/14"
    static let group_description = "그룹 소개"
    static let group_description_placeholder = " 그룹을 소개해주세요."
    static let group_description_count = "00/72"
    static let group_description_maxCount = "72"
    static let group_organization = "소속(선택)"
    static let group_organization_placeholder = "Ex) 홍익대학교"
    static let group_organization_count = "00/15"
    static let group_register = "그룹 등록하기"
    
    static let group_complete_text = "그룹 등록이 완료되었습니다!"
    static let group_owner_text = "관리자"
    static let group_accessCode_text = "참여코드"
    static let group_invite_text = "그룹에 가입하기 위해서는 참여코드를 입력해야 합니다.\n코드를 공유하고 멤버들을 초대해보세요!"
    static let confirm_text = "확인"
    
    // MARK: - Group Setting
    
    static let setting_title = "모임 설정"
    static let accessCode_change_title = "참여코드 변경"
    static let member_title = "멤버 관리"
    static let owner_title = "관리자 변경"
    
    static let access_current = "현재 참여코드"
    static let access_code = "000000"
    static let access_new = "새 참여코드"
    static let access_subTitle = "영문, 숫자를 조합하여 사용 가능합니다."
    static let access_count = "0/6"
    static let access_placeholder = " 6자리 참여 코드를 입력하세요."
    static let access_currentCount = "%d"
    
    static let member_title_info = "그룹에 속해있는 멤버와 임시 멤버를 관리할 수 있습니다."
    static let member_placeholder = "   멤버 검색"
    static let member_delete = "멤버 삭제"
    
    static let owner_title_info = "관리자 권한을 넘길 멤버를 선택해주세요."
    static let owner_placeholder = "   멤버 검색"
    
    // MARK: - Game Result Record
    
    static let game_result_title = "게임 결과 기록"
    static let game_result_title_info = "플레이 한 보드게임을 선택해주세요"
    static let game_player_title_info = "게임을 함께 플레이 한 멤버를 선택해주세요"
    static let game_player_confirm = "플레이어 선택 완료"
    
    static let game_record_calendar = "yy/MM/dd"
    static let game_record_time = "hh:mm"
    static let game_record_title_info = "게임 결과를 입력해주세요!"
    static let game_record_title = "결과 기록"
    
    static let game_record_rank = "위"
    static let game_record_placeholder = "0"
    static let game_record_score = "점"
    static let game_record_confirm = "기록 완료"
    
    // MARK: - PopupView
    
    static let bottom_title = "상대방이 아직 온보드에 가입하지 않았다면\n임시 멤버로 추가해보세요!"
    static let bottom_subTitle = "이후 온보드 가입 시 닉네임으로 기록을 연동할 수 있습니다."
    static let bottom_textField_placeholder = "임시 멤버가 사용할 닉네임을 입력해주세요."
    static let bottom_textField_count = "00/10"
    static let bottom_register_button = "임시 멤버 추가"
    static let bottom_textField_already = "이미 있는 이름입니다. 다른 이름을 설정해주세요."
}
