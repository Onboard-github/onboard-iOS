//
//  GroupSettingViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class GroupSettingViewController: UIViewController {
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 25
    }
    
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
    
    // MARK: - Initialize
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.view.backgroundColor = Colors.White
        
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
