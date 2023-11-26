//
//  DevelopVC.swift
//  onboard-iOS
//
//  Created by main on 11/26/23.
//

import UIKit

class DevelopVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        AlertManager.show(message: "로그아웃 후 앱이 종료됩니다") {
            LoginSessionManager.logout()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                exit(0)
            })
        }
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
