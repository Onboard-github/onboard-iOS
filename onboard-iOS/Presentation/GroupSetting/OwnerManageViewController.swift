//
//  OwnerManageViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/10/24.
//

import UIKit

import ReactorKit

final class OwnerManageViewController: UIViewController, View {
    
    typealias Reactor = GroupReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Metric
    
    private enum Metric {
        static let iconSize: CGFloat = 16
        static let topMargin: CGFloat = 25
        static let leftRightMargin: CGFloat = 20
        static let textFieldTopSpacing: CGFloat = 10
        static let textFieldHeight: CGFloat = 40
        static let tableViewTopSpacing: CGFloat = 20
        static let tableViewBottomSpacing: CGFloat = 10
        static let buttonBottomMargin: CGFloat = 10
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.owner_title_info
        label.textColor = Colors.Gray_10
        label.font = Font.Typography.body3_R
        return label
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
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: TextLabels.owner_placeholder,
                                                             attributes: attributes)
        return textField
    }()
    
    private lazy var tableView: UITableView = {
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
        button.setTitle(TextLabels.owner_confirm, for: .normal)
        return button
    }()
    
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
        let gameId = GameDataSingleton.shared.gameData?.id ?? 0
        self.reactor?.action.onNext(.allPlayerData(groupId: groupId, gameId: gameId))
    }
    
    func bindState(reactor: GroupReactor) {
        reactor.state
            .compactMap { $0.allPlayer }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.tableView.reloadData()
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
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.confirmButton)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Metric.tableViewTopSpacing)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-Metric.tableViewBottomSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Metric.buttonBottomMargin)
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
        navigationItem.title = TextLabels.owner_title
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OwnerManageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return reactor?.currentState.allPlayer.first?.contents.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerManageTableViewCell",
                                                 for: indexPath) as! OwnerManageTableViewCell
        
        let me = reactor?.currentState.allPlayer.first?.contents.filter({ $0.userId == LoginSessionManager.meId }).first
        
        if let player = reactor?.currentState.allPlayer.first?.contents[indexPath.row] {
            let hideOwner = me != nil && me?.userId == player.userId
            let diceImage = player.role == "GUEST" ? IconImage.emptyDice.image : IconImage.dice.image
            cell.isHidden = hideOwner
            cell.configure(image: diceImage, title: player.nickname, showMeImage: false)
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        guard let me = reactor?.currentState.allPlayer.first?.contents.filter({ $0.userId == LoginSessionManager.meId }).first,
              let player = reactor?.currentState.allPlayer.first?.contents[indexPath.row] else {
            return 0
        }
        
        return (me.userId == player.userId) ? 0 : 52
    }
}
