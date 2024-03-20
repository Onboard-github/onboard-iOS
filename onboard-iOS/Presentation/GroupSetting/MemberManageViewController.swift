//
//  MemberManageViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

import ReactorKit

final class MemberManageViewController: UIViewController, View {
    
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
    }
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.member_title_info
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
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 52
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.delegate = self
        view.dataSource = self
        view.register(MemberManageTableViewCell.self,
                      forCellReuseIdentifier: "MemberManageTableViewCell")
        return view
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
        
        self.textFieldPlaceHolder()
        self.makeConstraints()
        self.setNavigationBar()
        self.setupGestureRecognizer()
    }
    
    private func textFieldPlaceHolder() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: TextLabels.member_placeholder,
                                                             attributes: attributes)
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.tableView)
        
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
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
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
        navigationItem.title = TextLabels.member_title
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func backgroundTapped() {
        self.view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MemberManageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return tmpData.count
        }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberManageTableViewCell",
                                                 for: indexPath) as! MemberManageTableViewCell
        let (image, label) = tmpData[indexPath.row]
        cell.configure(image: image, title: label)
        return cell
    }
}
