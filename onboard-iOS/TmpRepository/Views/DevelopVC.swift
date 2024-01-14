//
//  DevelopVC.swift
//  onboard-iOS
//
//  Created by main on 11/26/23.
//

import UIKit

class DevelopVC: UIViewController {
    @IBOutlet weak var groupInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            let result = try await OBNetworkManager.shared.asyncRequest(object: GroupInfoRes.self, router: .groupInfo(groupId: LoginSessionManager.currentGroupId ?? -1))
            if let result = result.value {
                groupInfoLabel.text = "현재 가입된 그룹 정보: \(result)"
            }
        }
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        LoginSessionManager.logout()
        exit(0)
    }
}
