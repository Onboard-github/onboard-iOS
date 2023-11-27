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

class RankVC: UIViewController {

    private var gameList: GamgeList? {
        didSet {
            pagingViewController.reloadData()
        }
    }
    
    fileprivate let icons = [
        "compass",
        "cloud",
        "bonnet",
        "axe",
        "earth",
        "knife",
        "leave",
        "light",
        "map",
        "moon",
        "mushroom",
        "shoes",
        "snow",
        "star",
        "sun",
        "tipi",
        "tree",
        "water",
        "wind",
        "wood",
    ]
    @IBOutlet weak var pagingBackground: UIView!
    let pagingViewController = PagingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagingViewController.register(IconPagingCell.self, for: IconItem.self)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
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

extension RankVC: PagingViewControllerDataSource {
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return UIViewController()
    }

    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return IconItem(iconUrl: gameList?.list[index].img ?? "", index: index)
    }

    func numberOfViewControllers(in _: PagingViewController) -> Int {
        return gameList?.list.count ?? 0
    }
}

struct IconItem: PagingItem, Hashable {
    let iconUrl: String
    let index: Int

    init(iconUrl: String, index: Int) {
        self.iconUrl = iconUrl
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
            titleLabel.text = "!@#"

            if viewModel.selected {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                imageView.alpha = 1
                titleLabel.font = .boldSystemFont(ofSize: 15)
                titleLabel.alpha = 1
            } else {
                imageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                imageView.alpha = 0.6
                titleLabel.font = .boldSystemFont(ofSize: 12)
                titleLabel.alpha = 0.6
            }

            self.viewModel = viewModel
        }
    }

    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let viewModel = viewModel else { return }
        if let attributes = layoutAttributes as? PagingCellLayoutAttributes {
            let scale = (0.4 * attributes.progress) + 0.6
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
            constant: -25
        )

        let leadingContraint = NSLayoutConstraint(
            item: imageView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0
        )

        let trailingContraint = NSLayoutConstraint(
            item: imageView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0
        )

        contentView.addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint,
        ])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(7)
            make.leading.trailing.equalToSuperview().inset(6)
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
