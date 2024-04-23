//
//  UpdateUserInfoViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 4/21/24.
//

import UIKit

final class UpdateUserInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private let updateUserInfoView = UpdateUserInfoView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = updateUserInfoView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = TextLabels.userInfo_title
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
