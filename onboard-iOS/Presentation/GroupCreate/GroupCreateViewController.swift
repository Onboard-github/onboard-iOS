//
//  GroupCreateViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/26.
//

import UIKit

import ReactorKit

final class GroupCreateViewController: UIViewController {
    
    private let groupCreateView = GroupCreateView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = groupCreateView
    }
}
