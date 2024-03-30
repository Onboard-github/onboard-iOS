//
//  MyProfileViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/30/24.
//

import UIKit

final class MyProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let myProfileView = MyProfileView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = myProfileView
    }
}
