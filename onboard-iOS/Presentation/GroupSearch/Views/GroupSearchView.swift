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

final class GroupSearchView: UIView {
    var disposeBag = DisposeBag()
    
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
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "활동하고 계신\n보드게임 모임을 찾아주세요."
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return titleLabel
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        return bar
    }()
    
    private let addGroupButton: UIButton = {
        let button = UIButton()
        button.setTitle("우리 모임 새로 등록하기 +", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var controlsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.searchBar)
        stackView.addArrangedSubview(self.addGroupButton)
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemRed
        return tableView
    }()
    
    private let button = UIButton()
    
    // MARK: - Properties
    var didTapButton: (() -> Void)?

    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Bind
    func bind(groupList: [GroupEntity.Res.Group]) {
        let groupsObservable = Observable.just(groupList)
        tableView.delegate = nil
        tableView.dataSource = nil
        
        groupsObservable
            .bind(to: tableView.rx.items(cellIdentifier: "GroupSearchCell", cellType: GroupSearchCell.self)) { (row, group, cell) in
                cell.titleLabel.text = group.name
                cell.subTitleLabel.text = group.description
                if let imageUrl = URL(string: group.profileImageUrl) {
                    cell.thumbnailView.kf.setImage(with: imageUrl)
                }
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Configure
    private func configure() {
        self.backgroundColor = .systemBackground
        button.backgroundColor = .lightGray
        
        tableView.register(GroupSearchCell.self, forCellReuseIdentifier: "GroupSearchCell")
        self.addActionConfigure()
        self.makeConstraints()
    }

    private func addActionConfigure() {
        self.button.addAction(UIAction(handler: { _ in
            self.didTapButton?()
        }), for: .touchUpInside)
    }

    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(Metric.titleTop)
            make.leading.trailing.equalToSuperview().inset(Metric.side)
        }
        
        self.addSubview(self.controlsStack)
        controlsStack.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.Controls.stackTop)
            make.leading.trailing.equalToSuperview().inset(Metric.side)
        }
        
        self.addSubview(self.tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.controlsStack.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(Metric.side)
            make.bottom.equalToSuperview()
        }
    }
}
