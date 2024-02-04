//
//  GroupJoinVC.swift
//  onboard-iOS
//
//  Created by main on 12/17/23.
//

import UIKit
import Alamofire
import Kingfisher

class GroupJoinVC: UIViewController {
    var group: GroupSearchView.Group? {
        didSet {
            backgroundImgView.kf.setImage(with: URL(string: group?.profileImageUrl ?? ""))
            affiliationLabel.text = group?.organization
            groupName.text = group?.name
            descriptionLabel.text = group?.description
        }
    }
    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //스켈레톤 적용
        affiliationLabel.text = nil
        groupName.text = nil
        descriptionLabel.text = nil
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinButtonAction(_ sender: Any) {
//        print("group Id \(group?.id)")

        let codeVC = JoinCodeVC(nibName: "JoinCodeVC", bundle: .main)
        codeVC.modalTransitionStyle = .crossDissolve
        codeVC.modalPresentationStyle = .overFullScreen
        present(codeVC, animated: true)
        
//        Task { [weak self] in
//            let addedResult2 = try await OBNetworkManager.shared.asyncRequest(object: Empty.self, router: .addGroupGuest(groupId: group?.id ?? -1, nickName: "test"))
//            print(addedResult2)
//            if let result = addedResult2.value {
//                print(result)
//            }
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
//            homeTabController.modalPresentationStyle = .fullScreen
//            navigationController?.present(homeTabController, animated: true)
//            LoginSessionManager.setState(state: .login)
//        }
    }

}
