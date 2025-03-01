//
//  RankVC.swift
//  onboard-iOS
//
//  Created by main on 11/26/23.
//

import UIKit
import Alamofire
import Parchment
import SnapKit
import Kingfisher

enum RankVcState {
    case loading
    case notJoinedGroup
    case loaded
}

class RankVC: UIViewController {
    var selectedGameId: Int?
    var gameInfo: [LeaderboardGame] = [] {
        didSet {
            gameDetailTableView.reloadData()
        }
    }
    var meInfo: GetMeRes?
    
    var rankedGameInfo: [LeaderboardGame] {
        gameInfo.filter({ $0.rank != nil }).sorted(by: { $0.rank! < $1.rank! })
    }
    var unrankedGameInfo: [LeaderboardGame] {
        gameInfo.filter({ $0.rank == nil })
    }
    
    var joinedGroupList: GetMyGroupsV2Res? {
        didSet {
            guard let list = joinedGroupList?.contents else { return }
            print("가입 수 : \(list.count)")
            for group in list {
                print("groupId:", group.id)
                GameDataSingleton.shared.setGroupId(group.id)
            }
            
            var menus: [UIMenuElement] = []
            
            // 메뉴 항목을 생성합니다.
            let groupAddMenu = UIAction(title: "새 그룹 가입", image: nil, handler: { [weak self] _ in
                let useCase = GroupSearchUseCaseImpl(groupRepository: GroupRepositoryImpl())
                let groupList = GroupSearchViewController(reactor: GroupSearchReactor(useCase: useCase))
                let navVC = UINavigationController(rootViewController: groupList)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
            })
            menus.append(groupAddMenu)
            
            list.forEach { group in
                let groupAddMenu = UIAction(title: group.name, image: nil, handler: { _ in
                    // 목록 1 선택 시 실행할 코드
//                    Task {
                        self.getGroupInfo(groupId: group.id)
//                    }
                    print("\(group.name) 선택됨")
                })
                menus.append(groupAddMenu)
            }
            
            let menu = UIMenu(title: "", children: menus)
                
            // 버튼에 메뉴를 설정합니다.
            titleLabelButton.menu = menu
            titleLabelButton.showsMenuAsPrimaryAction = true
            
            if list.count > 0 {
                getGroupInfo(groupId: joinedGroupList?.contents.first?.id ?? -1)
            }
            if list.count == 0 {
                state = .notJoinedGroup
            }
            gameDetailTableView.reloadData()
        }
    }
    var selectedGroupInfo: GroupInfoRes? {
        didSet {
            titleLabelButton.setTitle(selectedGroupInfo?.name, for: .normal)
            if let id = selectedGroupInfo?.id {
                GameDataSingleton.shared.setGroupId(id)
                LoginSessionManager.meMemberId = joinedGroupList?.contents.filter({$0.id == id}).first?.memberId
            }
            // 메뉴 항목을 생성합니다.
            // 임시 주석 처리
//            var menus: [UIMenuElement] = []
//            
//            let groupAddMenu = UIAction(title: "가입 코드 보기", image: nil, handler: { [weak self] _ in
//                AlertManager.show(message: "가입 코드: \(self?.selectedGroupInfo?.accessCode ?? "")")
//            })
//            menus.append(groupAddMenu)
//            
//            let menu = UIMenu(title: "", children: menus)
//                
//            // 버튼에 메뉴를 설정합니다.
//            moreButton2.menu = menu
//            moreButton2.showsMenuAsPrimaryAction = true
            
            
//            state = .loaded
//            gameDetailTableView.reloadData()
        }
    }
    
    var state: RankVcState = .loaded {
        didSet {
            if state == .notJoinedGroup || state == .loading {
                titleLabelButton.isHidden = true
                titleLabelArrow.isHidden = true
                moreButton.isHidden = true
                moreButton2.isHidden = true
                recordButton.isHidden = true
            } else {
                titleLabelButton.isHidden = false
                titleLabelArrow.isHidden = false
                moreButton.isHidden = false
                moreButton2.isHidden = false
                recordButton.isHidden = false
            }
            
            gameDetailTableView.reloadData()
        }
    }
    
    @IBOutlet weak var moreButton: UIImageView!
    @IBOutlet weak var moreButton2: UIButton!
    @IBOutlet weak var titleLabelArrow: UIImageView!
    @IBOutlet weak var titleLabelButton: UIButton!
    
    private var gameList: GamgeList? {
        didSet {
            pagingViewController.reloadData()
        }
    }
    @IBOutlet weak var gameDetailTableView: UITableView!

    @IBOutlet weak var pagingBackground: UIView!
    let pagingViewController = PagingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileManager.refresh()
        pagingViewController.register(IconPagingCell.self, for: IconItem.self)
        pagingViewController.delegate = self
        pagingViewController.menuItemSize = .fixed(width: 80, height: 120)
        pagingViewController.dataSource = self
        pagingViewController.borderColor = .clear
        pagingViewController.indicatorColor = .clear
        pagingViewController.view.subviews.forEach { view in
            view.backgroundColor = .black
        }
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(pagingBackground)
        }
        pagingViewController.didMove(toParent: self)
        gameDetailTableView.dataSource = self
        gameDetailTableView.delegate = self
        gameDetailTableView.bounces = false
        gameDetailTableView.allowsSelection = false
        
        self.configureButton()
        
        self.moreButton2.addAction(UIAction(handler: { [weak self] _ in
            let useCase = GroupUseCaseImpl(repository: GroupRepositoryImpl())
            let playerUseCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
            let memberUseCase = MemberUseCaseImpl(repository: MemberRepositoryImpl())
            let reactor = GroupReactor(useCase: useCase, playerUseCase: playerUseCase, memberUseCase: memberUseCase)
            let groupInfoDetailViewController = GroupInfoDetailViewController(reactor: reactor)
            groupInfoDetailViewController.modalPresentationStyle = .overFullScreen
            self?.present(groupInfoDetailViewController, animated: false)
        }), for: .touchUpInside)
        
        
        Task {
            let meInfoResult = try await OBNetworkManager.shared.asyncRequest(object: GetMeRes.self, router: .getMe)
            self.meInfo = meInfoResult.value
            LoginSessionManager.meId = meInfoResult.value?.id
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveNotification), name: Notification.Name("groupDeleted"), object: nil)
    }
    
    @objc func didRecieveNotification(_ notification: Notification) {
        refresh()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    private func refresh() {
        getJoinedGroups()
        fetchGameList()
    }
    
    private func fetchGameList() {
        Task {
            do {
                let result = try await OBNetworkManager
                    .shared
                    .asyncRequest(
                        object: GamgeList.self,
                        router: OBRouter.gameList
                    )
                
                guard let data = result.value else {
                    throw NetworkError.noExist
                }
                
                if result.response?.statusCode == 200 {
                    gameList = result.value
                } else {
                    AlertManager.show(message: "응답이 200이 아님 \(result.response?.statusCode)")
                }
                
            } catch {
                AlertManager.show(message: error.localizedDescription)
                throw error
            }
        }
    }
    
    private let recordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_plusGame"), for: .normal)
        return button
    }()
    
    private func configureButton() {
        self.gameDetailTableView.addSubview(self.recordButton)
        
        self.recordButton.snp.makeConstraints {
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        self.recordButton.addAction(UIAction { [weak self] _ in
            let reactor = GameResultReactor(useCase: GameResultUseCaseImpl(repository: GameResultRepositoryImpl()))
            let vc = UINavigationController(rootViewController: GameResultViewController(reactor: reactor))
            vc.modalPresentationStyle = .overFullScreen
            self?.present(vc, animated: true)
        }, for: .touchUpInside)
    }
    
    private func getGameInfo(gameId: Int) {
        Task {
            let result = try await OBNetworkManager
                .shared
                .asyncRequest(
                    object: GameLeaderboardRes.self,
                    router: OBRouter.gameLeaderboard(groupId: selectedGroupInfo?.id ?? -1, gameId: gameId)
                )
            if let gameInfo = result.value?.contents {
                self.gameInfo = gameInfo
            } else {
                self.gameInfo = []
            }
            
            let memberId = result.value?.contents.first?.memberId
            GameDataSingleton.shared.memberId.accept(memberId ?? -1)
            
            self.state = .loaded
        }
    }
}

extension RankVC: PagingViewControllerDelegate {
    func pagingViewController(_ pagingViewController: PagingViewController, didSelectItem pagingItem: PagingItem) {
        if state == .notJoinedGroup {
            return
        }
        
        if let item = pagingItem as? IconItem {
            self.state = .loading
            getGameInfo(gameId: item.gameId)
            selectedGameId = item.gameId
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
                if self?.joinedGroupList?.contents.count == 0 {
                    self?.state = .notJoinedGroup
                }
            })
        }
    }
}

extension RankVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .notJoinedGroup:
            return 1
        case .loading:
            return 5
        case .loaded:
            return unrankedGameInfo.count + 1 + (max(rankedGameInfo.count - 3, 0))
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.state {
        case .notJoinedGroup:
            return tableView.dequeueReusableCell(withIdentifier: "emptyGroupCell", for: indexPath)
        case .loading:
            if indexPath.row == 0 {
                return tableView.dequeueReusableCell(withIdentifier: "podiumSkeletonCell", for: indexPath)
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "gameSkeletonCell", for: indexPath) as? GameSkeletonCell {
                    cell.showAnimation()
                    return cell
                }
            }
        case .loaded:
            if indexPath.row == 0 {
                if rankedGameInfo.count == 0, unrankedGameInfo.count != 0 {
                    if let emptyMatchedCell = tableView.dequeueReusableCell(withIdentifier: "emptyMatchedCell", for: indexPath) as? EmptyMatchedCell {
                        return emptyMatchedCell
                    }
                } else {
                    if let podiumCell = tableView.dequeueReusableCell(withIdentifier: "podiumCell", for: indexPath) as? PodiumCell {
                        var info = PodiumUserInfo()
                        info.dice = .empty
                        info.isEmptyUser = true
                        info.isMe = false
                        info.isRedDot = false
                        info.playCount = 0
                        info.playCount = 0
                        info.score = 0
                        info.userName = ""
                        
                        if let ranker1 = rankedGameInfo.first(where: {$0.rank == 1}) {
                            if ranker1.role == "GUEST" {
                                info.dice = .empty
                            } else {
                                info.dice = .dice
                            }
                            info.isEmptyUser = false
                            if ranker1.userId == meInfo?.id {
                                info.isMe = true
                            }
                            if ranker1.isChangeRecent {
                                info.isRedDot = true
                            }
                            info.playCount = ranker1.matchCount ?? 0
                            info.score = ranker1.score ?? 0
                            info.userName = ranker1.nickname
                        }
                        
                        var info2 = PodiumUserInfo()
                        info2.dice = .empty
                        info2.isEmptyUser = true
                        info2.isMe = false
                        info2.isRedDot = false
                        info2.playCount = 0
                        info2.playCount = 0
                        info2.score = 0
                        info2.userName = ""
                        
                        if let ranker2 = rankedGameInfo.first(where: {$0.rank == 2}) {
                            if ranker2.role == "GUEST" {
                                info2.dice = .empty
                            } else {
                                info2.dice = .dice
                            }
                            info2.isEmptyUser = false
                            if ranker2.userId == meInfo?.id {
                                info2.isMe = true
                            }
                            if ranker2.isChangeRecent {
                                info2.isRedDot = true
                            }
                            info2.playCount = ranker2.matchCount ?? 0
                            info2.score = ranker2.score ?? 0
                            info2.userName = ranker2.nickname
                        }
                        
                        var info3 = PodiumUserInfo()
                        info3.dice = .empty
                        info3.isEmptyUser = true
                        info3.isMe = false
                        info3.isRedDot = false
                        info3.playCount = 0
                        info3.playCount = 0
                        info3.score = 0
                        info3.userName = ""
                        
                        if let ranker3 = rankedGameInfo.first(where: {$0.rank == 3}) {
                            if ranker3.role == "GUEST" {
                                info3.dice = .empty
                            } else {
                                info3.dice = .dice
                            }
                            info3.isEmptyUser = false
                            if ranker3.userId == meInfo?.id {
                                info3.isMe = true
                            }
                            if ranker3.isChangeRecent {
                                info3.isRedDot = true
                            }
                            info3.playCount = ranker3.matchCount ?? 0
                            info3.score = ranker3.score ?? 0
                            info3.userName = ranker3.nickname
                        }
                        
                        podiumCell.firstUserInfo = info
                        podiumCell.secondUserInfo = info2
                        podiumCell.thirdUserInfo = info3
                        
                        return podiumCell
                    }
                }
            } else {
                let remainedRankedCount = max((rankedGameInfo.count - 3), 0)
                
                let unrankedIndex = indexPath.row - 1
                
                if remainedRankedCount > unrankedIndex {
                    let ranker = rankedGameInfo[3 + unrankedIndex]
                    
                    if let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameCell {
                        var info = GameCellInfo(rankNum: indexPath.row)
                        
                            if ranker.role == "GUEST" {
                                info.dice = .empty
                            } else {
                                info.dice = .dice
                            }
                            if ranker.userId == meInfo?.id {
                                info.isMe = true
                            } else {
                                info.isMe = false
                            }
                            if ranker.isChangeRecent {
                                info.isRedDot = true
                            } else {
                                info.isRedDot = false
                            }
                            info.playCount = ranker.matchCount ?? 0
                            info.score = ranker.score ?? 0
                        
                        info.userName = ranker.nickname

                        info.rankNum = ranker.rank ?? -1
                        gameCell.info = info
                        return gameCell
                    }
                } else {
                    let unranker = unrankedGameInfo[unrankedIndex - remainedRankedCount]
                    
                    if let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameCell {
                        var info = GameCellInfo(rankNum: indexPath.row)
                        
                            if unranker.role == "GUEST" {
                                info.dice = .empty
                            } else {
                                info.dice = .dice
                            }
                            if unranker.userId == meInfo?.id {
                                info.isMe = true
                            } else {
                                info.isMe = false
                            }
                            if unranker.isChangeRecent {
                                info.isRedDot = true
                            } else {
                                info.isRedDot = false
                            }
                            info.playCount = unranker.matchCount ?? 0
                            info.score = unranker.score ?? 0
                        
                        info.userName = unranker.nickname

                        info.rankNum = unranker.rank ?? -1
                        gameCell.info = info
                        return gameCell
                    }
                }
            }
        }
        
        return UITableViewCell()
    }
    
    private func getJoinedGroups() {
        Task {
            let result = try await OBNetworkManager.shared.asyncRequest(object: GetMyGroupsV2Res.self, router: .getMyGroupsV2)
            if let result = result.value {
                joinedGroupList = result
            }
        }
    }
    
    private func getGroupInfo(groupId: Int) {
        Task {
            let result = try await OBNetworkManager.shared.asyncRequest(object: GroupInfoRes.self, router: .groupInfo(groupId: groupId))
            if let result = result.value {
                print("!@#@# \(result)")
                self.selectedGroupInfo = result
                if let gameId = self.selectedGameId, gameId > 0 {
                    self.getGameInfo(gameId: gameId)
                }
            }
        }
    }
}

extension RankVC: PagingViewControllerDataSource {
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return UIViewController()
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let calculatedIndex = index - 2
        if calculatedIndex >= 0 && calculatedIndex < (gameList?.list.count ?? 0) {
            return IconItem(iconUrl: gameList?.list[calculatedIndex].img ?? "", title: gameList?.list[calculatedIndex].name ?? "", index: index, gameId: gameList?.list[calculatedIndex].id ?? -1)
        } else {
            return IconItem(iconUrl: "", title: "", index: index, gameId: -1)
        }
    }

    func numberOfViewControllers(in _: PagingViewController) -> Int {
        if let gameCount = gameList?.list.count {
            return gameCount + 4
        } else {
            return 0
        }
    }
}

struct IconItem: PagingItem, Hashable {
    let iconUrl: String
    let title: String
    let index: Int
    let gameId: Int

    init(iconUrl: String, title: String, index: Int, gameId: Int) {
        self.iconUrl = iconUrl
        self.title = title
        self.index = index
        self.gameId = gameId
    }

    func isBefore(item: PagingItem) -> Bool {
        if let item = item as? PagingIndexItem {
            return index < item.index
        } else if let item = item as? Self {
            return index < item.index
        } else {
            return false
        }
    }
}

class IconPagingCell: PagingCell {
    fileprivate var viewModel: IconPagingCellViewModel?

    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
        if let item = pagingItem as? IconItem {
            let viewModel = IconPagingCellViewModel(
                selected: selected,
                options: options
            )
            
            // 이미지 로딩
            imageView.kf.setImage(with: URL(string: item.iconUrl)) { [weak self] _ in
                // 마스크 이미지 로딩
                if let maskImage = UIImage(named: "maskImg"), let original = self?.imageView.image {
                    
                    let maskImageView = UIImageView(image: maskImage)
                    // 이미지를 마스킹
                    self?.imageView.mask = maskImageView
                }
            }
            
            
            
            titleLabel.text = item.title
            
            if viewModel.selected {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                imageView.alpha = 1
                titleLabel.font = .boldSystemFont(ofSize: 13)
                titleLabel.alpha = 1
            } else {
                imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                imageView.alpha = 0.7
                titleLabel.font = .boldSystemFont(ofSize: 10)
                titleLabel.alpha = 0.7
            }
            
            self.viewModel = viewModel
        }
    }
    
    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let viewModel = viewModel else { return }
        if let attributes = layoutAttributes as? PagingCellLayoutAttributes {
            let scale = (0.3 * attributes.progress) + 0.7
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            imageView.tintColor = UIColor.interpolate(
                from: viewModel.tintColor,
                to: viewModel.selectedTintColor,
                with: attributes.progress
            )
        }
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let topContraint = NSLayoutConstraint(
            item: imageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .top,
            multiplier: 1.0,
            constant: 10
        )

        let bottomConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -35
        )

        let leadingContraint = NSLayoutConstraint(
            item: imageView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 5
        )

        let trailingContraint = NSLayoutConstraint(
            item: imageView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: -5
        )

        contentView.addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint,
        ])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(7)
            make.leading.trailing.equalToSuperview().inset(-3)
            make.bottom.equalToSuperview()
        }
    }
}

struct IconPagingCellViewModel {
    let selected: Bool
    let tintColor: UIColor
    let selectedTintColor: UIColor

    init(selected: Bool, options: PagingOptions) {
        self.selected = selected
        tintColor = options.textColor
        selectedTintColor = options.selectedTextColor
    }
}
