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
}
