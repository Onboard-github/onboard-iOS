//
//  GroupCreateCompleteViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/22/23.
//

import UIKit

final class GroupCreateCompleteViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private let groupCreateCompleteView = GroupCreateCompleteView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = groupCreateCompleteView
    }
    
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
        
        self.addConfigure()
    }
    
    private func addConfigure() {
        self.groupCreateCompleteView.didTapConfirmButtonAction = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = homeTabController
            }
        }
    }
}
