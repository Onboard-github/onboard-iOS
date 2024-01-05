//
//  GroupCreateViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/26.
//

import UIKit

import ReactorKit

final class GroupCreateViewController: UIViewController, View {
    
    typealias Reactor = GroupCreateReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    private let groupCreateView = GroupCreateView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = groupCreateView
    }
    
    // MARK: - Initialize

    init(reactor: GroupCreateReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind(reactor: GroupCreateReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: GroupCreateReactor) {
        reactor.action.onNext(.randomImage)
    }
    
    func bindState(reactor: GroupCreateReactor) {
        reactor.state
            .map { $0.imageURL }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                ImageLoader.loadImage(from: data) { image in
                    self?.groupCreateView.titleImageView.image = image
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.addConfigure()
        self.setNavigationBar()
    }
    
    private func addConfigure() {
        self.groupCreateView.didImageViewButton = { [self] in
            let useCase = GroupCreateUseCaseImpl(repository: GroupCreateRepositoryImpl())
            let reactor = GroupCreateReactor(useCase: useCase)
            let imagePopupVC = ImagePopupViewController(reactor: reactor)
            imagePopupVC.modalPresentationStyle = .overFullScreen
            
            imagePopupVC.imageCompletion = { [self] selectedImage in
                groupCreateView.titleImageView.image = selectedImage
                self.dismiss(animated: false, completion: nil)
            }
            
            self.present(imagePopupVC, animated: false, completion: nil)
        }
        
        self.groupCreateView.didTapRegisterButton = { [self] in
            let useCase = GroupCreateUseCaseImpl(repository: GroupCreateRepositoryImpl())
            let reactor = GroupCreateReactor(useCase: useCase)
            let nameInputVC = NameInputPopupView(reactor: reactor)
            nameInputVC.modalPresentationStyle = .overFullScreen
            
            self.present(nameInputVC, animated: false, completion: nil)
        }
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
