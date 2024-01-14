//
//  GroupJoinVC.swift
//  onboard-iOS
//
//  Created by main on 12/17/23.
//

import UIKit
import Alamofire

class GroupJoinVC: UIViewController {
    var group: GroupSearchView.Group? {
        didSet {
            groupName.text = group?.name
        }
    }
    @IBOutlet weak var groupName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinButtonAction(_ sender: Any) {
//        print("group Id \(group?.id)")
//        
//        Task { [weak self] in
//            let addedResult = try await OBNetworkManager.shared.asyncRequest(object: GroupMembersRes.self, router: .groupMembers(groupId: group?.id ?? -1))
//            print(addedResult)
//            if let result = addedResult.value {
//                print(result)
//            }
//            
//            let addedResult2 = try await OBNetworkManager.shared.asyncRequest(object: Empty.self, router: .addGroupGuest(groupId: group?.id ?? -1, nickName: "test"))
//            print(addedResult2)
//            if let result = addedResult2.value {
//                print(result)
//            }
//            
//            let addedResult3 = try await OBNetworkManager.shared.asyncRequest(object: GroupMembersRes.self, router: .groupMembers(groupId: group?.id ?? -1))
//            print(addedResult3)
//            if let result = addedResult3.value {
//                print(result)
//            }
//        }
        
        LoginSessionManager.currentGroupId = group?.id
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
        homeTabController.modalPresentationStyle = .fullScreen
        navigationController?.present(homeTabController, animated: true)
        LoginSessionManager.setState(state: .login)
    }

}
