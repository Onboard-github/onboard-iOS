//
//  MyProfileViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/30/24.
//

import UIKit

final class MyProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private let myProfileView = MyProfileView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = myProfileView
    }
    
    // MARK: - Initialize
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Configure
    
    private func configure() {
        
        self.setNavigationBar()
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(Colors.Black, renderingMode: .alwaysOriginal)
        
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
        navigationItem.title = TextLabels.profile_title
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}
