//
//  DevelopVC.swift
//  onboard-iOS
//
//  Created by main on 11/26/23.
//

import UIKit
import Alamofire

class DevelopVC: UIViewController {
    @IBOutlet weak var groupInfoLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    private func refresh() {
        Task {
            let result = try await OBNetworkManager.shared.asyncRequest(object: GetMyGroupsV2Res.self, router: .getMyGroupsV2)
            groupInfoLabel.text = "가입 그룹 갯수: \(result.value?.contents.count ?? -999)"
            
            let meInfoResult = try await OBNetworkManager.shared.asyncRequest(object: GetMeRes.self, router: .getMe)
            userInfoLabel.text = "닉네임: \(meInfoResult.value?.nickname ?? ""), id: \(meInfoResult.value?.id ?? -1)"
        }
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        LoginSessionManager.logout()
        exit(0)
    }
    
    @IBAction func myGroupClean(_ sender: Any) {
        Task {
            let result = try await OBNetworkManager.shared.asyncRequest(object: GetMyGroupsV2Res.self, router: .getMyGroupsV2)
            if let groups = result.value?.contents {
                for group in groups {
                    try? await OBNetworkManager.shared.asyncRequest(object: Empty.self, router: .myGroupUnsubscribe(groupId: group.groupId))
                    try? await OBNetworkManager.shared.asyncRequest(object: Empty.self, router: .groupDelete(groupId: group.groupId))
                    refresh()
                }
            }
        }
    }
}
