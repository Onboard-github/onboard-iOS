//
//  GroupSearchView.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import UIKit
import SnapKit
import RxSwift
import Kingfisher

protocol GroupSearchDelegate {
    func select(group: GroupSearchView.Group?)
}

final class GroupSearchView: UIView {
    
    var delegate: GroupSearchDelegate?
    var groupList: [Group]?

    // MARK: - Metric
    private enum Metric {
        static let titleTop = 20
        static let side: CGFloat = 18
        
        enum Controls {
            static let stackTop = 26
            static let stackBottom = 24
        }
    }
    
    // MARK: - UI
    private let closeButton: UIButton = {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        return button
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "모임 둘러보기"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return titleLabel
    }()
    
    private let searchBar: GroupSearchBar = {
        let bar = GroupSearchBar()
        bar.placeholder = "모임 이름 검색"
        bar.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        return bar
    }()
    
    private let addGroupButton: NewGroupButton = {
        let button = NewGroupButton()
        button.setTitle("우리 모임 새로 등록하기 +", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var controlsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.searchBar)
        let buttonBackgroundView = UIView()
        buttonBackgroundView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        buttonBackgroundView.addSubview(self.addGroupButton)
        addGroupButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        stackView.addArrangedSubview(buttonBackgroundView)
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    var didTapAddGroupButton: (() -> Void)?
    var searchBarValueChanged: ((String) -> Void)?
    var didTapCloseButton: (() -> Void)?
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Bind
    func bind(groupList: [Group]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Group>()
        snapshot.appendSections([0])
        snapshot.appendItems(groupList)
        self.groupList = groupList
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    lazy var dataSource: UITableViewDiffableDataSource<Int, Group> = {
        UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, group in
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GroupSearchCell", for: indexPath) as? GroupSearchCell {
                cell.titleLabel.text = group.name
                cell.infoLabel.text = group.organization
                cell.subTitleLabel.text = group.description
                cell.backgroundColor = .clear
                if let imageUrl = URL(string: group.profileImageUrl) {
                    cell.thumbnailView.kf.setImage(with: imageUrl)
                }
                return cell
            } else {
                return UITableViewCell()
            }
        })
    }()
    
    // MARK: - Configure
    private func configure() {
        self.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        
        tableView.register(GroupSearchCell.self, forCellReuseIdentifier: "GroupSearchCell")
        tableView.delegate = self
        tableView.backgroundColor = .clear
        self.addActionConfigure()
        self.makeConstraints()
    }

    private func addActionConfigure() {
        self.addGroupButton.addAction(UIAction(handler: { _ in
            self.didTapAddGroupButton?()
        }), for: .touchUpInside)
        
        self.closeButton.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapCloseButton?()
        }), for: .touchUpInside)
        
        searchBar.rx.text
            .distinctUntilChanged() // 이전 값과 같은 경우 무시
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // 입력 후 0.5초 대기
            .subscribe(onNext: { [weak self] text in
                self?.searchBarValueChanged?(text ?? "")
            })
            .disposed(by: disposeBag)
    }

    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(Metric.titleTop)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(self.closeButton)
        closeButton.setImage(UIImage(named: "cross"), for: .normal)
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        self.addSubview(self.controlsStack)
        controlsStack.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.Controls.stackTop)
            make.leading.trailing.equalToSuperview().inset(Metric.side)
        }
        
        self.addSubview(self.tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.controlsStack.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension GroupSearchView {
    struct Group: Codable, Hashable {
        let id: Int
        let name: String
        let description: String
        let organization: String
        let profileImageUrl: String
    }
}

extension GroupSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.select(group: groupList?[indexPath.row])
    }
}
