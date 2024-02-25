//
//  ProfileVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/26/24.
//

import UIKit
import SnapKit

class ProfileVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gameCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileManager.refresh()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = (ProfileManager.profileName ?? "error") + " 님"
        gameCountLabel.text = "\(ProfileManager.gameCount ?? -1)"
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 28))
        let label = UILabel()
        label.textColor = .label
        label.text = "프로필"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        background.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        return background
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
