//
//  AppSettingVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/26/24.
//

import UIKit
import SafariServices

class AppSettingVC: UIViewController {
    struct SettingItem {
        var isSeparator: Bool
        var title: String
        var action: (UIViewController?) -> Void
        
        init(_ title: String, _ action: @escaping (UIViewController?) -> Void, _ isSeparator: Bool = false) {
            self.title = title
            self.action = action
            self.isSeparator = isSeparator
        }
    }
    
    let contents: [SettingItem] = [
        
        SettingItem("회원 정보 수정", { vc in
            let useCase = UserUseCaseImpl(repository: UserRepositoryImpl())
            let playerUseCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
            let groupUseCase = GroupUseCaseImpl(repository: GroupRepositoryImpl())
            let memberUseCase = MemberUseCaseImpl(repository: MemberRepositoryImpl())
            let reactor = UserReactor(userUseCase: useCase, playerUseCase: playerUseCase, groupUseCase: groupUseCase, memberUseCase: memberUseCase)
            let userInfoVC = UpdateUserInfoViewController(reactor: reactor)
            vc?.navigationController?.pushViewController(userInfoVC, animated: true)
        }),
        
        SettingItem("문의", { _ in
            AlertManager.show(title: "문의", message: "help.onboardgame@gmail.com\n문의는 이메일로 부탁드립니다.")
        }),
        
        SettingItem("개인정보 처리방침", { vc in
            if let url = URL(string: "http://api.onboardgame.co.kr/privacy.html") {
                let safariViewController = SFSafariViewController(url: url)
                vc?.present(safariViewController, animated: true)
            }
        }),
        
        SettingItem("서비스 이용 약관", { vc in
            if let url = URL(string: "http://api.onboardgame.co.kr/terms.html") {
                let safariViewController = SFSafariViewController(url: url)
                vc?.present(safariViewController, animated: true)
            }
        }),
//        SettingItem("오픈소스 라이선스", { _ in }),
        SettingItem("", { _ in }, true),
        
        SettingItem("회원 탈퇴", { vc in
            let removeVC = RemoveIDVC(nibName: "RemoveIDVC", bundle: .main)
            vc?.navigationController?.pushViewController(removeVC, animated: true)
        })
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingItem = contents[indexPath.row]
        if settingItem.isSeparator {} else {
            settingItem.action(self)
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
