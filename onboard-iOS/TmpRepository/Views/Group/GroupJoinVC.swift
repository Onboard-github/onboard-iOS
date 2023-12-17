//
//  GroupJoinVC.swift
//  onboard-iOS
//
//  Created by main on 12/17/23.
//

import UIKit

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
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
