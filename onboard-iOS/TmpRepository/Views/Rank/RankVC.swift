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
    var joinedGroupList: GetMyGroupsV2Res? {
        didSet {
            guard let list = joinedGroupList?.contents else { return }
            print("가입 수 : \(list.count)")
            
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
                let groupAddMenu = UIAction(title: group.groupName, image: nil, handler: { _ in
                    // 목록 1 선택 시 실행할 코드
                    print("\(group.groupName) 선택됨")
                })
                menus.append(groupAddMenu)
            }
            
            let menu = UIMenu(title: "", children: menus)
                
            // 버튼에 메뉴를 설정합니다.
            titleLabelButton.menu = menu
            titleLabelButton.showsMenuAsPrimaryAction = true
            
            if list.count > 0 {
                getGroupInfo(groupId: joinedGroupList?.contents.first?.groupId ?? -1)
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
            state = .loaded
            gameDetailTableView.reloadData()
        }
    }
    
    var state: RankVcState = .loading {
        didSet {
            if state == .notJoinedGroup || state == .loading {
                titleLabelButton.isHidden = true
                titleLabelArrow.isHidden = true
                moreButton.isHidden = true
            } else {
                titleLabelButton.isHidden = false
                titleLabelArrow.isHidden = false
                moreButton.isHidden = false
            }
            
            gameDetailTableView.reloadData()
        }
    }
    
    @IBOutlet weak var moreButton: UIImageView!
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
}

extension RankVC: PagingViewControllerDelegate {
    func pagingViewController(_ pagingViewController: PagingViewController, didSelectItem pagingItem: PagingItem) {
        if state == .notJoinedGroup {
            return
        }
        
        if let item = pagingItem as? IconItem {
            self.state = .loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
                if self?.joinedGroupList?.contents.count == 0 {
                    self?.state = .notJoinedGroup
                } else {
                    self?.state = .loaded
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
            return 10
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
                if let podiumCell = tableView.dequeueReusableCell(withIdentifier: "podiumCell", for: indexPath) as? PodiumCell {
                    var info = PodiumUserInfo()
                    if Bool.random() {
                        info.dice = .dice
                    } else {
                        info.dice = .empty
                    }
                    info.isEmptyUser = Bool.random()
                    info.isMe = Bool.random()
                    info.isRedDot = Bool.random()
                    info.playCount = Int.random(in: 1...999)
                    info.score = Int.random(in: 0...999)
                    info.userName = "ASDASDASD"
                    
                    var info2 = PodiumUserInfo()
                    if Bool.random() {
                        info2.dice = .dice
                    } else {
                        info2.dice = .empty
                    }
                    info2.isEmptyUser = Bool.random()
                    info2.isMe = Bool.random()
                    info2.isRedDot = Bool.random()
                    info2.playCount = Int.random(in: 1...999)
                    info2.score = Int.random(in: 0...999)
                    info2.userName = "ASDASDASD"
                    
                    var info3 = PodiumUserInfo()
                    if Bool.random() {
                        info3.dice = .dice
                    } else {
                        info3.dice = .empty
                    }
                    info3.isEmptyUser = Bool.random()
                    info3.isMe = Bool.random()
                    info3.isRedDot = Bool.random()
                    info3.playCount = Int.random(in: 1...999)
                    info3.score = Int.random(in: 0...999)
                    info3.userName = "ASDASDASD"
                    
                    podiumCell.firstUserInfo = info
                    podiumCell.secondUserInfo = info2
                    podiumCell.thirdUserInfo = info3
                    
                    return podiumCell
                }
            } else {
                if let gameCell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameCell {
                    var info = GameCellInfo(rankNum: indexPath.row)
                    info.userName = "귤귤사람귤귤귤사람귤"
                    if Bool.random() {
                        info.dice = .dice
                    } else {
                        info.dice = .empty
                    }
                    info.isMe = Bool.random()
                    info.isRedDot = Bool.random()
                    info.playCount = Int.random(in: 1...999)
                    info.rankNum = indexPath.row + 3
                    info.score = Int.random(in: 0...999)
                    gameCell.info = info
                    return gameCell
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
                self.selectedGroupInfo = result
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
            return IconItem(iconUrl: gameList?.list[calculatedIndex].img ?? "", title: gameList?.list[calculatedIndex].name ?? "", index: index)
        } else {
            return IconItem(iconUrl: "", title: "", index: index)
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

    init(iconUrl: String, title: String, index: Int) {
        self.iconUrl = iconUrl
        self.title = title
        self.index = index
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

            imageView.kf.setImage(with: URL(string: item.iconUrl))
            
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
