//
//  PlayerSelectViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/16/24.
//

import UIKit

import ReactorKit

final class PlayerSelectViewController: UIViewController, View {
    
    typealias Reactor = PlayerReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Metric
    
    private enum Metric {
        static let iconSize: CGFloat = 16
        static let progressBarHeight: CGFloat = 2
        static let labelTopSpacing: CGFloat = 15
        static let leftRightMargin: CGFloat = 20
        static let collectionViewTopSpacing: CGFloat = 20
        static let collectionViewHeight: CGFloat = 68
        static let textFieldTopSpacing: CGFloat = 20
        static let buttonLeftSpacing: CGFloat = 10
        static let tableViewSpacing: CGFloat = 10
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.tintColor = Colors.Orange_5
        bar.trackTintColor = Colors.Orange_1
        bar.progress = 2.0 / 3.0
        return bar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.game_player_title_info
        label.textColor = Colors.Gray_10
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let playerLabel: UILabel = {
        let label = UILabel()
        label.text = GameDataSingleton.shared.gameData.map { "\($0.minMember)~\($0.maxMember)명" }
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private lazy var playerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Colors.White
        view.isHidden = true
        
        view.register(PlayerCollectionViewCell.self,
                      forCellWithReuseIdentifier: "PlayerCollectionViewCell")
        return view
    }()
    
    private let textField: TextField = {
        let textField = TextField()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Metric.iconSize + 20, height: Metric.iconSize))
        let image = UIImageView(image: IconImage.search_gray.image)
        image.contentMode = .center
        image.frame = CGRect(x: 0, y: 0, width: Metric.iconSize, height: Metric.iconSize)
        view.addSubview(image)
        textField.rightView = view
        textField.rightViewMode = .always
        
        textField.textColor = Colors.Gray_15
        textField.font = Font.Typography.body2_M
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        let image = IconImage.plusButton
        button.setImage(image.image, for: .normal)
        return button
    }()
    
    private lazy var playerTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 52
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.delegate = self
        view.dataSource = self
        view.register(OwnerManageTableViewCell.self,
                      forCellReuseIdentifier: "OwnerManageTableViewCell")
        return view
    }()
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .rounded)
        button.setTitle(TextLabels.game_player_confirm, for: .normal)
        return button
    }()
    
    // MARK: - Initialize
    
    init(reactor: PlayerReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind(reactor: PlayerReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: PlayerReactor) {
        reactor.action.onNext(.fetchResult(groupId: 123,
                                           size: "앙"))
    }
    
    func bindState(reactor: PlayerReactor) {
        reactor.state
            .map { $0.playerData }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.playerTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.view.backgroundColor = Colors.White
        
        self.makeConstraints()
        self.setNavigationBar()
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.progressBar)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.playerLabel)
        self.view.addSubview(self.playerCollectionView)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.addButton)
        self.view.addSubview(self.playerTableView)
        self.view.addSubview(self.confirmButton)
        
        self.progressBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.progressBarHeight)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.playerLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.playerCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.collectionViewTopSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.collectionViewHeight)
        }
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.addButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.top)
            $0.bottom.equalTo(textField.snp.bottom)
            $0.leading.equalTo(textField.snp.trailing).offset(Metric.buttonLeftSpacing)
            $0.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.playerTableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Metric.tableViewSpacing)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-Metric.tableViewSpacing)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(Metric.leftRightMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(Colors.Black, renderingMode: .alwaysOriginal)
        
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
        navigationItem.title = GameDataSingleton.shared.gameData?.name
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PlayerSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return reactor?.currentState.playerData.first?.contents.count ?? 0
        }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerManageTableViewCell",
                                                     for: indexPath) as! OwnerManageTableViewCell
            
            let image = IconImage.dice.image
            
            if let data = reactor?.currentState.playerData,
               let firstGameList = data.first?.contents,
               indexPath.item < firstGameList.count {
                
                let game = firstGameList[indexPath.item]
                
                cell.configure(image: image,
                               title: game.nickname)
            }
            
            return cell
        }
}
