//
//  TextLabels.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/2/23.
//

import Foundation

struct TextLabels {
    
    // MARK: - String to exclude from textField
    
    static let exclude_string = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅑㅓㅕㅗㅛㅐㅜㅠㅡㅣㅔㅐㅟㅚㅢㅝㅖㅒㅙ~`!@#$%^&*()_-+=[]{};:'<,>.?/"
    
    // MARK: - App Setting - UserInfo
    
    static let userInfo_title = "회원 정보 수정"
    static let userInfo_textTitle = "사용 중인 닉네임"
    static let userInfo_newTextInputTitle = "새 이름"
    static let userInfo_textField_placeholder = "이름을 입력해주세요"
    static let userInfo_textField_subTitle = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
    static let userInfo_textField_count = "00/10"
    static let userInfo_confirm = "수정 완료"
    
    // MARK: - Group Create
    
    static let group_title = "모임 등록"
    static let group_name = "모임 이름"
    static let group_name_placeholder = "모임 이름을 입력해주세요."
    static let group_name_count = "00/14"
    static let group_description = "모임 소개"
    static let group_description_placeholder = " 모임을 소개해주세요."
    static let group_description_count = "00/72"
    static let group_description_maxCount = "72"
    static let group_organization = "소속(선택)"
    static let group_organization_placeholder = "Ex) 홍익대학교"
    static let group_organization_count = "00/15"
    static let group_register = "모임 등록하기"
    static let group_memberCount = "명"
    static let group_playCount = "회 플레이"
    
    static let group_complete_text = "모임 등록이 완료되었습니다!"
    static let group_owner_text = "관리자"
    static let group_accessCode_text = "참여코드"
    static let group_member_countText = "멤버수"
    static let group_invite_text = "모임에 가입하기 위해서는 참여코드를 입력해야 합니다.\n코드를 공유하고 멤버들을 초대해보세요!"
    static let confirm_text = "확인"
    static let exit_text = "모임 나가기"
    static let group_clipboard_message = "클립보드에 복사되었습니다."
    
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
    static let access_confirm = "수정 완료"
    
    static let member_title_info = "그룹에 속해있는 멤버와 임시 멤버를 관리할 수 있습니다."
    static let member_placeholder = "   멤버 검색"
    static let member_delete = "멤버 삭제"
    
    static let owner_title_info = "관리자 권한을 넘길 멤버를 선택해주세요."
    static let owner_placeholder = "   멤버 검색"
    static let owner_confirm = "선택 완료"
    static let owner_loading = "관리자 변경이 완료되었습니다."
    
    static let group_delete_loading = "잠시만 기다려주세요."
    static let group_delete_complete = "모임을 삭제했습니다."
    
    // MARK: - Group List
    
    static let groupList_title = "내 모임"
    static let groupList_nextGroup = "모임 둘러보기"
    
    // MARK: - Game Result Record
    
    static let game_result_title = "게임 결과 기록"
    static let game_result_title_info = "플레이 한 보드게임을 선택해주세요"
    
    static let game_player_title_info = "게임을 함께 플레이 한 멤버를 선택해주세요"
    static let game_player_search_placeholder = "   멤버 검색"
    static let game_player_confirm = "플레이어 선택 완료"
    
    static let game_record_calendar = "yy/MM/dd"
    static let game_record_time = "hh:mm"
    static let game_record_title_info = "게임 결과를 입력해주세요!"
    static let game_record_title = "결과 기록"
    
    static let game_record_rank = "위"
    static let game_record_placeholder = "0"
    static let game_record_score = "점"
    static let game_record_confirm = "기록 완료"
    static let game_record_player_count = "인 플레이"
    static let game_record_guide = "최종 기록 이후 점수 수정이 불가능합니다\n정말로 확정하시겠습니까?"
    static let game_record_register = "기록 확정"
    static let game_record_recording = "모임을 등록하는 중.. "
    
    // MARK: - Profile
    
    static let profile_title = "프로필 수정"
    static let profile_groupLabel = "모임 이름"
    static let profile_nickname = "사용 중인 닉네임"
    static let profile_newNickname = "새 닉네임"
    static let profile_textField_placeholder = "닉네임을 입력해주세요"
    static let profile_textField_subTitle = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
    static let profile_textField_count = "00/10"
    static let profile_confirm = "수정 완료"
    
    // MARK: - PopupView
    
    static let image_popup_title = "그룹 대표 이미지"
    static let image_popup_subTitle = "그룹을 소개하는 이미지를 넣어주세요."
    static let image_popup_fileUpload = "앨범에서 사진 선택"
    static let image_popup_random = "랜덤 이미지"
    
    static let owner_popup_title = "관리자 프로필 설정"
    static let owner_popup_subTitle = "그룹에서 사용할 닉네임을 10자 이하로 입력해주세요."
    static let owner_popup_textFieldSubTitle = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
    static let owner_popup_count = "00/10"
    static let owner_popup_register = "그룹 등록하기"
    
    static let bottom_title = "상대방이 아직 온보드에 가입하지 않았다면\n임시 멤버로 추가해보세요!"
    static let bottom_subTitle = "이후 온보드 가입 시 닉네임으로 기록을 연동할 수 있습니다."
    static let bottom_textField_placeholder = "임시 멤버가 사용할 닉네임을 입력해주세요."
    static let bottom_textField_count = "00/10"
    static let bottom_register_button = "임시 멤버 추가"
    static let bottom_textField_already = "이미 있는 이름입니다. 다른 이름을 설정해주세요."
    
    static let imageLoading_loading = "점수 기록 중.."
    static let imageLoading_complete = "점수 기록이 완료되었습니다!"
    
    // MARK: - EmptyView
    
    static let search_empty_title = "에 대한 검색어가 없습니다."
    static let search_empty_subTitle = "함께 보드게임을 플레이한 상대가 온보드에\n아직 없다면, 임시 멤버로 추가해 기록해보세요!"
    
    // MARK: - ConfirmPopupView
    
    static let groupInfo_groupDelete_message = "모임 삭제 시 모임과 관련된 모든 기록이\n삭제되며, 취소 또는 복구는 불가능합니다.\n\n"
    static let groupInfo_groupDelete_delete_message = "모임을 삭제하시겠습니끼?"
    static let groupInfo_message = "모임에서 나가면 내 랭킹과 게임 기록이 모두\n삭제되며, 취소 또는 복구가 불가능합니다.\n\n"
    static let groupInfo_exit_message = "모임에서 나가시겠습니까?"
    
    static let groupInfo_owner_message = "현재 모임의 관리자입니다. 모임을 나가시려면\n"
    static let groupInfo_owner_move = "모임 설정 > 관리자 변경"
    static let groupInfo_owner_move_message = "메뉴에서 다른 멤버를\n관리자로 지정한 후 다시 시도해 주세요.\n\n관리자 변경 페이지로 이동하시겠습니까?"
    
    static let groupInfo_onlyOwner_message = "현재 모임의 유일한 멤버입니다. 모임을\n나가시려면"
    static let groupInfo_onlyOwner_move = " 모임 설정 > 모임 삭제"
    static let groupInfo_onlyOwner_move_message = "메뉴에서\n모임을 삭제해주세요.\n\n모임 삭제 페이지로 이동하시겠습니까?"
    
    static let groupInfo_button_cancel = "취소"
    static let groupInfo_button_exit = "나가기"
    static let groupInfo_button_move = "이동하기"
    static let groupInfo_button_delete = "삭제하기"
    static let groupInfo_exit_alert = "그룹 나가기가 완료되었습니다."
    
    static let assginOwner_empty_Message = "관리자 권한을 넘길 멤버가 없습니다."
    static let assginOwner_Message = "관리자 권한을 넘기면 취소가 불가능합니다.\n\n관리자를"
    static let assginOwner_changeMessage = "님으로\n변경하시겠습니까?"
    static let assginOwner_button_assgin = "변경하기"
    
    static let memberManage_message = "멤버를 그룹에서 내보내면 해당 멤버의 기록이\n삭제되며, 취소 또는 복구는 불가능합니다.\n\n"
    static let memberManage_exit_message = "님을 내보내시겠습니까?"
    static let memberManage_button_exit = "내보내기"
}
