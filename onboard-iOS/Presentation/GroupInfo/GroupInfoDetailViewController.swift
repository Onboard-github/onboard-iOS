//
//  GroupInfoDetailViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

import ReactorKit

final class GroupInfoDetailViewController: UIViewController, View {
    
    typealias Reactor = GroupReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    private let groupInfoDetailView = GroupInfoDetailView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = groupInfoDetailView
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
                ImageLoader.loadImage(from: data.profileImageUrl) { [weak self] image in
                    DispatchQueue.main.async {
                        guard let image = image else { return }
                        self?.groupInfoDetailView.configureGroupInfo(
                            name: data.name,
                            titleImage: image,
                            description: data.description,
                            organization: data.organization,
                            memberCount: data.memberCount,
                            owner: data.owner.nickname,
                            accessCode: data.accessCode,
                            nickname: "닝",
                            playCount: 5
                        )
                    }
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.setupGestureRecognizer()
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func backgroundTapped() {
        self.dismiss(animated: false)
    }
}
