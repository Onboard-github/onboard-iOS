//
//  GroupSettingViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class GroupSettingViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 58
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        view.isScrollEnabled = false
        
        view.register(GroupSettingTableViewCell.self,
                      forCellReuseIdentifier: "GroupSettingTableViewCell")
        return view
    }()
}
