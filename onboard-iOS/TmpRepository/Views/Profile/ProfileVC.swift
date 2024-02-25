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
    
    var groupList: [MyGroup] {
        let decoder = JSONDecoder()
        if let data = ProfileManager.groupList {
            let gameList = try? decoder.decode([MyGroup].self, from: data)
            return gameList ?? []
        } else {
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileManager.refresh()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = (ProfileManager.profileName ?? "error") + " 님"
        gameCountLabel.text = "\(ProfileManager.gameCount ?? -1)"
        tableView.reloadData()
    }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        let settingVC = AppSettingVC(nibName: "AppSettingVC", bundle: .main)
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 28))
        let label = UILabel()
        label.textColor = .label
        label.text = "프로필"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        background.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        return background
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell {
            let group = groupList[indexPath.row]
            cell.leftTopLabel.text = group.name
            cell.rightTopLabel.text = group.organization
            cell.nicknameLabel.text = group.nickname
            cell.countLabel.text = "\(group.matchCount)회 플레이"
            
            return cell
        }
        return UITableViewCell()
    }
}
