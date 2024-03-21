//
//  AccessCodeViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

import ReactorKit

final class AccessCodeViewController: UIViewController, View {
    
    typealias Reactor = GroupReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    private let accessCodeView = AccessCodeView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = accessCodeView
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
        reactor.state
            .compactMap { $0.groupInfoData }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.accessCodeView.bind(text: data.accessCode)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Initialize
    
    init(reactor: GroupReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.setNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        if let navigationBar = navigationController?.navigationBar {
            let titleTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: Font.Typography.title2 as Any,
                NSAttributedString.Key.foregroundColor: Colors.Gray_14
            ]
            navigationBar.titleTextAttributes = titleTextAttributes
        }
        
        navigationController?.navigationBar.barTintColor = Colors.White
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image, style: .done,
            target: self, action: #selector(showPrevious))
        navigationItem.title = TextLabels.accessCode_change_title
    }
    
    @objc
    private func showPrevious() {
        navigationController?.popViewController(animated: true)
    }
}
