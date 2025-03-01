//
//  GroupJoinLoadingVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/7/24.
//

import UIKit
import Alamofire

class GroupJoinLoadingVC: UIViewController {
    var groupId: Int?
    var accessCode: String?
    var nickName: String?
    
    @IBOutlet weak var loadingIndicatorView: UIView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var completedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicatorView.isHidden = false
        completedView.isHidden = true
        
        // 닉네임과 '님' 부분에 대한 스타일을 설정합니다.
        let nickname = nickName ?? "닉네임"
        let greeting = " 님"

        // 닉네임에 적용할 속성을 설정합니다. (볼드, 사이즈 20)
        let nicknameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]

        // '님' 부분에 적용할 속성을 설정합니다. (사이즈 14)
        let greetingAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]

        // NSMutableAttributedString을 사용하여 서식 있는 문자열을 생성합니다.
        let attributedString = NSMutableAttributedString(string: nickname, attributes: nicknameAttributes)

        // '님' 부분을 추가합니다.
        let greetingAttributedString = NSAttributedString(string: greeting, attributes: greetingAttributes)
        attributedString.append(greetingAttributedString)

        // UILabel을 생성하고 attributedText 속성을 설정합니다.
        nicknameLabel.attributedText = attributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 로딩화면 2초 보여줌
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            [weak self] in
            Task { [weak self] in
                let result = try await OBNetworkManager
                    .shared
                    .asyncRequest(
                        object: Empty.self,
                        router: OBRouter.joinGroupHost(groupId: self?.groupId ?? -1, nickname: self?.nickName ?? "", accessCode: self?.accessCode ?? "", guestId: nil)                    )
                if result.response?.statusCode == 200 {
                    self?.loadingIndicatorView.isHidden = true
                    self?.completedView.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
                        self?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
                    })
                }
            }
        })
    }

    
}
