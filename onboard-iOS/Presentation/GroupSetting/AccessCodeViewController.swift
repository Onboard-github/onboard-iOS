//
//  AccessCodeViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class AccessCodeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let accessCodeView = AccessCodeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = accessCodeView
    }
}
