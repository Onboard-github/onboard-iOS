//
//  RemoveIDVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/27/24.
//

import UIKit
import Alamofire

class RemoveIDVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //백버튼 타이틀 지우기
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func removeButtonAction(_ sender: Any) {
        AlertManager.show(title: "탈퇴", message: """
        탈퇴 시 회원님의 랭킹과 게임 기록이 모두
        삭제되며, 취소 또는 복구는 불가능합니다.

        정말 탈퇴하시겠습니까?
        """, okHandler: {
            Task {
                // 모든 그룹 다 탈퇴/삭제
                let result2 = try await OBNetworkManager.shared.asyncRequest(object: GetMyGroupsV2Res.self, router: .getMyGroupsV2)
                if let groups = result2.value?.contents {
                    for group in groups {
                        try? await OBNetworkManager.shared.asyncRequest(object: Empty.self, router: .myGroupUnsubscribe(groupId: group.id))
                        try? await OBNetworkManager.shared.asyncRequest(object: Empty.self, router: .groupDelete(groupId: group.id))
                    }
                }
                
                // 유저 탈퇴 api 호출
                let result = try await OBNetworkManager
                    .shared
                    .asyncRequest(
                        object: Empty.self,
                        router: OBRouter.deleteUserMe
                    )
                if (result.response?.statusCode ?? 0) >= 200 && (result.response?.statusCode ?? 0) < 300 {
                    LoginSessionManager.logout()
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window {
                        window.rootViewController = UINavigationController(rootViewController: LoginSelectVC())
                        window.makeKeyAndVisible()
                    }
                } else if let data = result.data, let dataString = String(data: data, encoding: .utf8), dataString.contains("User002"), dataString.contains("오너인 그룹이 있어서 탈퇴 할 수 없습니다.") {
                    AlertManager.show(title: "애러",message: "오너인 그룹이 있어서 탈퇴 할 수 없습니다.")
                } else {
                    AlertManager.show(title: "애러 (탈퇴에 실패했습니다)", message: result.error?.localizedDescription ?? "nil")
                }
            }
        }, addCancel: true)
    }
}
