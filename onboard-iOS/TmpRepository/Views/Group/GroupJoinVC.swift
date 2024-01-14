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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
        homeTabController.modalPresentationStyle = .fullScreen
        navigationController?.present(homeTabController, animated: true)
        LoginSessionManager.setState(state: .login)
    }

}
