//
//  DevelopVC.swift
//  onboard-iOS
//
//  Created by main on 11/26/23.
//

import UIKit

class DevelopVC: UIViewController {
    @IBOutlet weak var groupInfoLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            let meInfoResult = try await OBNetworkManager.shared.asyncRequest(object: GetMeRes.self, router: .getMe)
            userInfoLabel.text = "닉네임: \(meInfoResult.value?.nickname ?? ""), id: \(meInfoResult.value?.id ?? -1)"
        }
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        LoginSessionManager.logout()
        exit(0)
    }
}
