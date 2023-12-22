//
//  GroupCreateCompleteViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/22/23.
//

import UIKit

final class GroupCreateCompleteViewController: UIViewController {
    
    private let groupCreateCompleteView = GroupCreateCompleteView()
    
    override func loadView() {
        super.loadView()
        
        self.view = groupCreateCompleteView
    }
}
