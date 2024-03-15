//
//  GroupListViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/15/24.
//

import UIKit

final class GroupListViewController: UIViewController {
    
    // MARK: - UI
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.White
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.groupList_title
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title1
        return label
    }()
    
    private lazy var listTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 52
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.register(GroupListTableViewCell.self,
                      forCellReuseIdentifier: "GroupListTableViewCell")
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLabels.groupList_nextGroup, for: .normal)
        button.setImage(IconImage.nextDefault.image, for: .normal)
        button.setTitleColor(Colors.Gray_7, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_M
        return button
    }()
}
