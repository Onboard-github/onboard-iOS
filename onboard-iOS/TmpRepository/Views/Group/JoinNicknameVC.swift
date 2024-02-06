//
//  JoinNicknameVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/5/24.
//

import UIKit

struct NicknameCheck: Codable{
    var isAvailable: Bool
    var reason: String?
}

class JoinNicknameVC: UIViewController {
    @IBOutlet weak var subtitleTextView: UILabel!
    @IBOutlet weak var nicknameTextInput: UITextView!
    @IBOutlet weak var roundedInputView: RoundedView!
    
    var groupId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameTextInput.delegate = self
        subtitleTextView.text = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
    }

    @IBAction func dimmedTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func joinButtonTap(_ sender: Any) {
        guard let groupId = groupId else { return }
        Task {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: NicknameCheck.self,
                    router: OBRouter.validateNickname(groupId: groupId, nickname: self.nicknameTextInput.text)
                )
            
            print(result.value)
            
            if result.value?.isAvailable == true {
                
            } else {
//                roundedInputView.borderWidth = 1
                subtitleTextView.textColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0)
                if result.value?.reason == "DUPLICATED_NICKNAME" {
                    subtitleTextView.text = "이미 있는 이름입니다. 다른 이름을 설정해주세요."
                } else if result.value?.reason == "INVALID_NICKNAME" {
                    subtitleTextView.text = "유효하지 않은 닉네임입니다. 다른 이름을 설정해주세요."
                } else {
                    subtitleTextView.text = "유효하지않은 닉네임 (\(result.value?.reason ?? "null"))"
                }
            }
        }
    }
    
    @IBAction func viewTap(_ sender: Any) {
        //뷰 터치시 화면 닫힘 방지
    }
}

extension JoinNicknameVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //텍스트 변하면 경고 메세지 삭제
        roundedInputView.borderWidth = 0
        subtitleTextView.text = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
        subtitleTextView.textColor = UIColor(red: 165.0/255, green: 165.0/255, blue: 165.0/255, alpha: 1.0)
    }
}
