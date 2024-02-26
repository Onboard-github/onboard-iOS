//
//  RemoveIDVC.swift
//  onboard-iOS
//
//  Created by m1pro on 2/27/24.
//

import UIKit

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
        """, okHandler: {}, addCancel: true)
    }
}
