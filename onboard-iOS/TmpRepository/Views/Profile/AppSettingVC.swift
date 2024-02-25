//
//  AppSettingVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/26/24.
//

import UIKit

class AppSettingVC: UIViewController {
    struct SettingItem {
        var isSeparator: Bool
        var title: String
        var action: () -> Void
        
        init(_ title: String, _ action: @escaping () -> Void, _ isSeparator: Bool = false) {
            self.title = title
            self.action = action
            self.isSeparator = isSeparator
        }
    }
    
    let contents: [SettingItem] = [
        SettingItem("회원 정보 수정", {}),
        SettingItem("문의", {}),
        SettingItem("개인정보 처리방침", {}),
        SettingItem("서비스 이용 약관", {}),
        SettingItem("오픈소스 라이선스", {}),
        SettingItem("", {}, true),
        SettingItem("회원 탈퇴", {})
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SettingCell", bundle: .main), forCellReuseIdentifier: "SettingCell")
        tableView.register(UINib(nibName: "SettingSeparatorCell", bundle: .main), forCellReuseIdentifier: "SettingSeparatorCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "앱 설정"
        
        //백버튼 타이틀 지우기
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension AppSettingVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingItem = contents[indexPath.row]
        if settingItem.isSeparator {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingSeparatorCell", for: indexPath) as? SettingSeparatorCell {
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell {
                cell.leftLabel.text = contents[indexPath.row].title
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let settingItem = contents[indexPath.row]
        if settingItem.isSeparator {
            return 8
        } else {
            return 52
        }
    }
}
