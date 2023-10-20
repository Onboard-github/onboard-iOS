//
//  GroupDetailViewController.swift
//  onboard-iOS
//
//  Created by main on 2023/10/20.
//

import UIKit

final class GroupDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let groupDetailView = GroupDetailView()
    
    // MARK: - Life Cycles
    override func loadView() {
        self.view = groupDetailView
    }
}
