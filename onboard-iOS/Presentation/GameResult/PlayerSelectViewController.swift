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
    
    private var filteredData: [PlayerEntity.Res.PlayerList] = []
    
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
        static let buttonBottomMargin: CGFloat = 10
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
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Colors.White
        view.showsHorizontalScrollIndicator = false
        view.isHidden = true
        
        view.delegate = self
        view.dataSource = self
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
        textField.font = Font.Typography.body3_R
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: TextLabels.game_player_search_placeholder,
                                                             attributes: attributes)
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
    
    private let emptyStateView: SearchEmptyStateView = {
        let view = SearchEmptyStateView()
        view.isHidden = true
        return view
    }()
    
    private let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = Colors.Orange_10
        return control
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - Bind
    
    func bind(reactor: PlayerReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: PlayerReactor) {
        self.fetchList()
    }
    
    func bindState(reactor: PlayerReactor) {
        reactor.state
            .map { $0.playerData }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.refresh()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.view.backgroundColor = Colors.White
        
        self.setRefresh()
        self.addConfigure()
        self.makeConstraints()
        self.setNavigationBar()
        
        self.searchPlayers()
        self.searchEmptyState()
    }
    
    private func setRefresh() {
        self.playerTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(
            self,
            action: #selector(refreshData(_:)),
            for: .valueChanged
        )
    }
    
    private func addConfigure() {
        self.addButton.addAction(UIAction(handler: { [weak self] _ in
            self?.addGuest()
        }), for: .touchUpInside)
        
        self.confirmButton.addAction(UIAction(handler: { [weak self] _ in
            let gameScoreViewController = GameScoreViewController()
            self?.navigationController?.pushViewController(gameScoreViewController, animated: true)
        }), for: .touchUpInside)
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
        navigationItem.title = GameDataSingleton.shared.gameData?.name
    }
    
    private func toggleLayout() {
        self.playerCollectionView.isHidden = GameDataSingleton.shared.gamePlayerData.isEmpty
        
        let topOffset = playerCollectionView.isHidden ? titleLabel.snp.bottom : playerCollectionView.snp.bottom
        textField.snp.remakeConstraints {
            $0.top.equalTo(topOffset).offset(Metric.textFieldTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setButtonStatus() {
        let selectedCount = GameDataSingleton.shared.gamePlayerData.count
        
        if let gameData = GameDataSingleton.shared.gameData {
            confirmButton.status = (gameData.minMember...gameData.maxMember ~= selectedCount) ? .default : .disabled
        }
    }
    
    @objc
    private func refreshData(_ sender: Any) {
        DispatchQueue.main.async {
            self.fetchList()
            self.refresh()
            self.playerTableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PlayerSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchText = self.textField.text,
           !searchText.isEmpty {
            let searchCount = filteredData.count
            return searchCount
        } else {
            let totalCount = reactor?.currentState.playerData.first?.contents.count ?? 0
            return totalCount
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "OwnerManageTableViewCell",
            for: indexPath
        ) as! OwnerManageTableViewCell
        
        var data: PlayerEntity.Res.PlayerList
        
        if let searchText = self.textField.text, !searchText.isEmpty {
            data = filteredData[indexPath.row]
        } else {
            guard let playerData = reactor?.currentState.playerData.first?.contents else {
                return cell
            }
            data = playerData[indexPath.row]
        }
        
        let titleImage = data.role == "GUEST" ? IconImage.emptyDice.image : IconImage.dice.image
        let titleColor: UIColor = data.role == "GUEST" ? Colors.Gray_9 : Colors.Gray_14
        let showMeImage = data.id == LoginSessionManager.meMemberId
        cell.configure(image: titleImage,
                       title: data.nickname,
                       titleColor: titleColor,
                       showMeImage: showMeImage)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OwnerManageTableViewCell else { return }
        
        var data: PlayerEntity.Res.PlayerList
        
        guard let playerData = reactor?.currentState.playerData.first?.contents else { return }
        
        if let searchText = self.textField.text, !searchText.isEmpty {
            data = filteredData[indexPath.row]
        } else {
            data = playerData[indexPath.row]
        }
        
        if GameDataSingleton.shared.gamePlayerData.contains(where: { $0.id == data.id }) {
            cell.updateButtonState(isSelected: false)
            GameDataSingleton.shared.removeGamePlayer(player: data)
        } else {
            cell.updateButtonState(isSelected: true)
            GameDataSingleton.shared.addGamePlayer(player: data)
        }
        
        self.setButtonStatus()
        self.playerCollectionView.reloadData()
        self.toggleLayout()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PlayerSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return GameDataSingleton.shared.gamePlayerData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PlayerCollectionViewCell",
            for: indexPath
        ) as! PlayerCollectionViewCell
        
        // collectionView cell 구성
        if GameDataSingleton.shared.gamePlayerData.indices.contains(indexPath.item) {
            let selectedPlayer = GameDataSingleton.shared.gamePlayerData[indexPath.item]
            let titleImage = selectedPlayer.role == "GUEST" ? IconImage.emptyDice.image : IconImage.dice.image
            let showMeImage = selectedPlayer.id == LoginSessionManager.meMemberId! ? true : false
            cell.configure(image: titleImage, showMeImage: showMeImage, title: selectedPlayer.nickname)
        }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.item < GameDataSingleton.shared.gamePlayerData.count,
              let selectedPlayer = GameDataSingleton.shared.gamePlayerData[safe: indexPath.item] else { return }
        
        if GameDataSingleton.shared.gamePlayerData.firstIndex(where: { $0.id == selectedPlayer.id }) != nil {
            GameDataSingleton.shared.removeGamePlayer(player: selectedPlayer)
            
            collectionView.deleteItems(at: [indexPath])
            
            if let tableViewCell = self.playerTableView.cellForRow(at: indexPath) as? OwnerManageTableViewCell {
                tableViewCell.updateButtonState(isSelected: false)
            }
            
            self.toggleLayout()
            self.setButtonStatus()
        }
        
        for index in 0..<self.playerTableView.numberOfRows(inSection: 0) {
            guard let cell = self.playerTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? OwnerManageTableViewCell else { continue }
            guard let playerData = reactor?.currentState.playerData.first?.contents else { continue }
            let data = playerData[index]
            cell.updateButtonState(isSelected: GameDataSingleton.shared.gamePlayerData.contains { $0.id == data.id })
            
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PlayerSelectViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 52, height: 68)
    }
}

extension PlayerSelectViewController {
    
    private func searchPlayers() {
        self.textField.rx.text
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let text = text else { return }
                if text.isEmpty {
                    self?.filteredData = self?.reactor?.currentState.playerData.first?.contents ?? []
                } else {
                    self?.filteredData = (self?.reactor?.currentState.playerData.first?.contents ?? []).filter { $0.nickname.contains(text) }
                }
                
                if self?.filteredData.isEmpty == true {
                    self?.showEmptyStateView()
                    self?.emptyStateView.setTitle(title: "'\(text)' \(TextLabels.search_empty_title)")
                } else {
                    self?.hideEmptyStateView()
                }
                
                self?.refresh()
            })
            .disposed(by: disposeBag)
    }
    
    private func showEmptyStateView() {
        self.emptyStateView.isHidden = false
        self.playerTableView.isHidden = true
        
        self.emptyStateView.didTapButton = {
            self.addGuest()
        }
    }
    
    private func hideEmptyStateView() {
        self.emptyStateView.isHidden = true
        self.playerTableView.isHidden = false
    }
    
    
    private func searchEmptyState() {
        self.view.addSubview(self.emptyStateView)
        
        self.emptyStateView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Metric.tableViewSpacing)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-Metric.tableViewSpacing)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension PlayerSelectViewController {
    private func addGuest() {
        let useCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
        let reactor = PlayerReactor(useCase: useCase)
        let bottom = BottomSheetViewController(reactor: reactor)
        
        bottom.contentView.snp.makeConstraints {
            $0.height.equalTo(260)
        }
        
        let popupState = PopupState(
            titleLabel: TextLabels.bottom_title,
            subTitleLabel: TextLabels.bottom_subTitle,
            textFieldPlaceholder: TextLabels.bottom_textField_placeholder,
            textFieldSubTitleLabel: "",
            countLabel: TextLabels.bottom_textField_count,
            buttonLabel: TextLabels.bottom_register_button
        )
        
        bottom.setState(popupState: popupState, onClickLink: { })
        bottom.modalPresentationStyle = .overFullScreen
        self.present(bottom, animated: false)
        
        bottom.didTapButton = { [weak self] in
            guard let nickname = GameDataSingleton.shared.guestNickNameData else { return }
            let groupId = GameDataSingleton.shared.getGroupId() ?? 0
            self?.reactor?.action.onNext(.addPlayer(groupId: groupId, nickName: nickname))
            self?.refresh()
            bottom.dismiss(animated: false)
            
            self?.fetchList()
            self?.refresh()
        }
    }
}

extension PlayerSelectViewController {
    
    private func fetchList() {
        let groupId = GameDataSingleton.shared.getGroupId() ?? 0
        self.reactor?.action.onNext(.fetchResult(groupId: groupId, size: "100"))
    }
    
    private func refresh() {
        self.playerTableView.reloadData()
    }
}
