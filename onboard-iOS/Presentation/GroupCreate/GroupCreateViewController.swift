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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        if let navigationBar = navigationController?.navigationBar {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: Font.Typography.title2 as Any,
                NSAttributedString.Key.foregroundColor: Colors.Gray_14
            ]
            navigationBar.titleTextAttributes = titleTextAttributes
        }
        
        navigationController?.navigationBar.barTintColor = Colors.Gray_2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image, style: .done,
            target: self, action: #selector(showPrevious))
        navigationItem.title = "그룹 등록"
    }
    
    @objc
    private func showPrevious() {
        self.dismiss(animated: true)
    }
}
