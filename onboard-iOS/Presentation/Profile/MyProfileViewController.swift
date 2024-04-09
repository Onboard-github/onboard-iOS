//
//  MyProfileViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/30/24.
//

import UIKit

import ReactorKit

final class MyProfileViewController: UIViewController, View {
    
    typealias Reactor = GroupReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    private let myProfileView = MyProfileView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = myProfileView
    }
    
    // MARK: - Initialize
    
    init(reactor: GroupReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Bind
    
    func bind(reactor: GroupReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: GroupReactor) {
        let groupId = GameDataSingleton.shared.getGroupId() ?? 0
        self.reactor?.action.onNext(.fetchResult(groupId: groupId))
    }
    
    func bindState(reactor: GroupReactor) {
        
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
