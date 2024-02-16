//
//  GroupInfoDetailViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

final class GroupInfoDetailViewController: UIViewController {
    
    private let groupInfoDetailView = GroupInfoDetailView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = groupInfoDetailView
    }
}
