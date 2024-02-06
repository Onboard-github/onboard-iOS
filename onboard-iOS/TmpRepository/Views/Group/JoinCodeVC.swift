//
//  JoinCodeVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/5/24.
//

import UIKit

struct AccessCodeCheck: Codable{
    var result: Bool
}

class JoinCodeVC: UIViewController {
    var groupId: Int?
    @IBOutlet weak var codeTextView: UITextView!
    @IBOutlet weak var roundedView: RoundedView!
    @IBOutlet weak var failTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        codeTextView.delegate = self
    }

    @IBAction func dimmedTap(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension JoinCodeVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 텍스트 뷰의 텍스트 길이가 6 이상인 경우 콘솔에 메시지 출력
        if textView.text.count >= 6 {
//            print("6글자 이상 입력되었습니다.")
            Task {
                let result = try await OBNetworkManager
                    .shared
                    .asyncRequest(
                        object: AccessCodeCheck.self,
                        router: OBRouter.groupAccessCodeCheck(groupId: groupId!, accessCode: textView.text.uppercased())
                    )
                if result.value?.result == true {
                    failTextLabel.isHidden = true
                    roundedView.borderWidth = 0
                    
                    let nicknameVC = JoinNicknameVC(nibName: "JoinNicknameVC", bundle: .main)
                    nicknameVC.modalTransitionStyle = .crossDissolve
                    nicknameVC.modalPresentationStyle = .overCurrentContext
                    nicknameVC.groupId = groupId
                    present(nicknameVC, animated: true)
                } else {
                    failTextLabel.isHidden = false
                    roundedView.borderWidth = 1
                }
            }
        }
    }
    
    // 텍스트 변경을 허용할지 결정하는 UITextViewDelegate 메소드
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 현재 텍스트의 길이와 대체될 텍스트의 길이를 기반으로 새로운 길이 계산
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        if updatedText.count < 6 {
            failTextLabel.isHidden = true
            roundedView.borderWidth = 0
        }
        
        // 업데이트된 텍스트 길이가 7 미만인 경우에만 텍스트 변경 허용
        return updatedText.count < 7
    }
}
