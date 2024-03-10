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
    var group: GroupSearchView.Group?
    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImgView.kf.setImage(with: URL(string: group?.profileImageUrl ?? ""))
        affiliationLabel.text = group?.organization
        groupName.text = group?.name
        descriptionLabel.text = group?.description
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinButtonAction(_ sender: Any) {
        let codeVC = JoinCodeVC(nibName: "JoinCodeVC", bundle: .main)
        codeVC.groupId = group?.id
        codeVC.modalTransitionStyle = .crossDissolve
        codeVC.modalPresentationStyle = .overFullScreen
        present(codeVC, animated: true)
    }

}
