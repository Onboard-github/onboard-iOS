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
        self.setNavigationBar()
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        if let navigationBar = navigationController?.navigationBar {
            let textAttribute: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: Font.Typography.title2 as Any,
                NSAttributedString.Key.foregroundColor: Colors.Gray_14
            ]
            navigationBar.titleTextAttributes = textAttribute
        }
        
        navigationController?.navigationBar.barTintColor = Colors.White
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image, style: .done,
            target: self, action: #selector(showPrevious))
        navigationItem.title = TextLabels.setting_title
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}
