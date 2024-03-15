//
//  GroupListViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/15/24.
//

import UIKit

final class GroupListViewController: UIViewController {
    
    // MARK: - Metric
    
    private enum Metric {
        static let basePadding: CGFloat = 30
        static let tableViewBottomSpacing: CGFloat = 15
        static let separatorViewBottomSpacing: CGFloat = 20
        static let separatorViewHeight: CGFloat = 1
        static let nextImageSize: CGFloat = 18
        static let stackViewBottomMargin: CGFloat = 60
    }
    
    // MARK: - Properties
    
    private var contentViewTopConstraint: NSLayoutConstraint!
    private var defaultHeight: CGFloat = 300
    
    // MARK: - UI
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.White
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.groupList_title
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title1
        return label
    }()
    
    private lazy var listTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 52
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.register(GroupListTableViewCell.self,
                      forCellReuseIdentifier: "GroupListTableViewCell")
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLabels.groupList_nextGroup, for: .normal)
        button.setTitleColor(Colors.Gray_7, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_M
        return button
    }()
    
    private let nextImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.nextDefault.image
        imageView.image = image
        return imageView
    }()
    
    private lazy var nextStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nextButton, nextImage])
        view.spacing = 7
        view.axis = .horizontal
        return view
    }()
    
    // MARK: - Initialize
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showMenu()
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.view.backgroundColor = Colors.White
        
        self.addConfigure()
        self.makeConstraints()
        self.setupGestureRecognizer()
    }
    
    private func addConfigure() {
        self.nextButton.addAction(UIAction(handler: { [weak self] _ in
            let useCase = GroupSearchUseCaseImpl(groupRepository: GroupRepositoryImpl())
            let groupList = GroupSearchViewController(reactor: GroupSearchReactor(useCase: useCase))
            let vc = UINavigationController(rootViewController: groupList)
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.dimmedView)
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.listTableView)
        self.contentView.addSubview(self.separatorView)
        self.contentView.addSubview(self.nextStackView)
        
        self.dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentViewTopConstraint,
        ])
        
        self.titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Metric.basePadding)
        }
        
        self.listTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.basePadding)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(separatorView.snp.top).offset(-Metric.tableViewBottomSpacing)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-Metric.separatorViewBottomSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.basePadding)
            $0.height.equalTo(Metric.separatorViewHeight)
        }
        
        self.nextImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.nextImageSize)
        }
        
        self.nextStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Metric.stackViewBottomMargin)
            $0.trailing.equalToSuperview().inset(Metric.basePadding)
        }
    }
    
    private func setupGestureRecognizer() {
        let dimmedTap = UITapGestureRecognizer(
            target: self,
            action: #selector(dimmedViewAction(_:))
        )
        
        self.dimmedView.addGestureRecognizer(dimmedTap)
        self.dimmedView.isUserInteractionEnabled = true
    }
    
    @objc
    private func dimmedViewAction(_ tapRecognizer: UITapGestureRecognizer)  {
        self.hideMenu()
    }
}

// MARK: - Menu Animation

extension GroupListViewController {
    
    private func showMenu() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        self.contentViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - self.defaultHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideMenu() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        self.contentViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}
