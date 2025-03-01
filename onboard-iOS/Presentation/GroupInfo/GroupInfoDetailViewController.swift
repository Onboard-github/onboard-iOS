//
//  GroupInfoDetailViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

import ReactorKit

final class GroupInfoDetailViewController: UIViewController, View {
    
    typealias Reactor = GroupReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Metric
    
    private enum Metric {
        static let topMargin: CGFloat = 30
        static let leadingTrailingMargin: CGFloat = 25
        static let settingButtonSize: CGFloat = 20
        static let itemSpacing: CGFloat = 15
        static let imageViewWidth: CGFloat = 114
        static let imageViewHeight: CGFloat = 162
        static let stackViewTopSpacing: CGFloat = 40
        static let codeImageSize: CGFloat = 18
        static let separatorViewHeight: CGFloat = 1
        static let profileViewHeight: CGFloat = 68
        static let diceImageSize: CGFloat = 28
        static let meImageSize: CGFloat = 14
        static let meStackViewTopMargin: CGFloat = 20
        static let countLabelTopSpacing: CGFloat = 5
        static let modifyButtonMargin: CGFloat = 10
        static let exitImageSize: CGFloat = 24
        static let bottomMargin: CGFloat = 15
        static let contentViewHeight: CGFloat = 214
    }
    
    // MARK: - UI
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_1
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        label.numberOfLines = 0
        return label
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(IconImage.settingDefault.image, for: .normal)
        return button
    }()
    
    private let groupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_12
        label.font = Font.Typography.body3_R
        label.numberOfLines = 0
        return label
    }()
    
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let memberImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.member
        imageView.image = image.image
        return imageView
    }()
    
    private let memberLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_member_countText
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let memberNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let ownerImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.manager
        imageView.image = image.image
        return imageView
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_owner_text
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let codeImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.code
        imageView.image = image.image
        return imageView
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.text =  TextLabels.group_accessCode_text
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let accessCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        let image = IconImage.copyDefault
        button.setImage(image.image, for: .normal)
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.White
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.Gray_2.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private let profileDiceImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.dice.image
        imageView.image = image
        return imageView
    }()
    
    private let meImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.me.image
        imageView.image = image
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body3_M
        return label
    }()
    
    private let playCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let modifyButton: UIButton = {
        let button = UIButton()
        button.setImage(IconImage.pencil.image, for: .normal)
        return button
    }()
    
    private let divView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
    
    private let exitImage: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.exit.image
        imageView.image = image
        return imageView
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLabels.exit_text, for: .normal)
        button.setTitleColor(Colors.Gray_10, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_M
        return button
    }()
    
    private lazy var memberStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [memberImage, memberLabel])
        stview.axis = .horizontal
        stview.spacing = 7
        return stview
    }()
    
    private lazy var ownerStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [ownerImage, ownerLabel])
        stview.axis = .horizontal
        stview.spacing = 7
        return stview
    }()
    
    private lazy var codeStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [codeImage, codeLabel])
        stview.axis = .horizontal
        stview.spacing = 7
        return stview
    }()
    
    private lazy var copyStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [accessCodeLabel, copyButton])
        stview.axis = .horizontal
        stview.spacing = 3
        return stview
    }()
    
    private lazy var meStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [meImage, nicknameLabel])
        stview.axis = .horizontal
        stview.spacing = 5
        return stview
    }()
    
    private lazy var exitStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [exitImage, exitButton])
        stview.axis = .horizontal
        stview.spacing = 5
        return stview
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
    
    // MARK: - Life Cycles
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showMenu()
    }
    
    // MARK: - Bind
    
    func bind(reactor: GroupReactor) {
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: GroupReactor) {
        let groupId = GameDataSingleton.shared.getGroupId() ?? 0
        let gameId = GameDataSingleton.shared.gameData?.id ?? 0
        let memberId = GameDataSingleton.shared.memberId.value
        self.reactor?.action.onNext(.fetchResult(groupId: groupId))
        self.reactor?.action.onNext(.allPlayerData(groupId: groupId, gameId: gameId))
        self.reactor?.action.onNext(.getMatchCount(groupId: groupId, memberId: memberId))
    }
    
    func bindState(reactor: GroupReactor) {
        reactor.state
            .compactMap { $0.groupInfoData }
            .withLatestFrom(reactor.state.map { $0.memberMatchCount }) { groupInfo, matchCount in
                (groupInfo, matchCount)
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                let (groupInfo, matchCount) = data
                
                let me = reactor.currentState.allPlayer.first?.contents.filter({ $0.userId == LoginSessionManager.meId }).first
                
                ImageLoader.loadImage(from: groupInfo.profileImageUrl) { [weak self] image in
                    DispatchQueue.main.async {
                        guard let image = image else { return }
                        self?.configureGroupInfo(
                            name: groupInfo.name,
                            titleImage: image,
                            description: groupInfo.description,
                            organization: groupInfo.organization,
                            memberCount: groupInfo.memberCount,
                            owner: groupInfo.owner.nickname,
                            accessCode: groupInfo.accessCode,
                            nickname: me?.nickname ?? "error",
                            playCount: matchCount?.matchCount ?? -1
                        )
                    }
                    
                    OnBoardSingleton.shared.myGroupNicknameText.accept(me?.nickname ?? "error")
                    
                    self?.settingButton.isHidden = me?.role == "OWNER" ? false : true
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.addConfigure()
        self.makeConstraints()
        self.setupGestureRecognizer()
        
        self.showMenu()
    }
    
    private func addConfigure() {
        self.copyButton.addAction(UIAction(handler: { [weak self] _ in
            let pasteboard = UIPasteboard.general
            pasteboard.string = self?.accessCodeLabel.text
            
            Toast().showToast(image: IconImage.dice.image!,
                              message: TextLabels.group_clipboard_message)
        }), for: .touchUpInside)
        
        self.modifyButton.addAction(UIAction(handler: { [weak self] _ in
            let userUseCase = UserUseCaseImpl(repository: UserRepositoryImpl())
            let playerUseCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
            let groupUseCase = GroupUseCaseImpl(repository: GroupRepositoryImpl())
            let memberUseCase = MemberUseCaseImpl(repository: MemberRepositoryImpl())
            let reactor = UserReactor(userUseCase: userUseCase, playerUseCase: playerUseCase, groupUseCase: groupUseCase, memberUseCase: memberUseCase)
            let myProfileViewController = MyProfileViewController(reactor: reactor)
            let navigationController = UINavigationController(rootViewController: myProfileViewController)
            navigationController.modalPresentationStyle = .overFullScreen
            navigationController.transitioningDelegate = self
            self?.present(navigationController, animated: true)
        }), for: .touchUpInside)
        
        self.exitButton.addAction(UIAction(handler: { [weak self] _ in
            guard let reactor = self?.reactor else { return }
            
            let me = reactor.currentState.allPlayer.first?.contents.first { $0.userId == LoginSessionManager.meId }
            
            switch (me?.role, reactor.currentState.groupInfoData?.memberCount ?? 0) {
            case ("OWNER", let count) where count >= 2:
                // 오너이자 멤버가 있는 경우
                let alert = ConfirmPopupViewController()
                alert.modalPresentationStyle = .overFullScreen
                
                let message = "\(TextLabels.groupInfo_owner_message)\(TextLabels.groupInfo_owner_move) \(TextLabels.groupInfo_owner_move_message)"
                let attributedString = NSMutableAttributedString(string: message)
                let range = (message as NSString).range(of: TextLabels.groupInfo_owner_move)
                attributedString.addAttribute(.font, value: Font.Typography.title4 as Any, range: range)
                
                let state = AlertState(contentLabel: attributedString,
                                       leftButtonLabel: TextLabels.groupInfo_button_cancel,
                                       rightButtonLabel: TextLabels.groupInfo_button_move)
                
                alert.setState(alertState: state)
                alert.setContentViewHeight(height: 234)
                
                alert.didTapConfirmButtonAction = { [weak self] in
                    self?.dismiss(animated: false)
                    let useCase = GroupUseCaseImpl(repository: GroupRepositoryImpl())
                    let playerUseCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
                    let memberUseCase = MemberUseCaseImpl(repository: MemberRepositoryImpl())
                    let reactor = GroupReactor(useCase: useCase, playerUseCase: playerUseCase, memberUseCase: memberUseCase)
                    let vc = OwnerManageViewController(reactor: reactor)
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .overFullScreen
                    navigationController.transitioningDelegate = self
                    self?.present(navigationController, animated: true)
                }
                
                self?.present(alert, animated: false)
                
            case ("OWNER", let count) where count == 1:
                // 오너이자 멤버가 오너(한 명)만 있는 경우
                let alert = ConfirmPopupViewController()
                alert.modalPresentationStyle = .overFullScreen
                
                let message = "\(TextLabels.groupInfo_onlyOwner_message)\(TextLabels.groupInfo_onlyOwner_move) \(TextLabels.groupInfo_onlyOwner_move_message)"
                let attributedString = NSMutableAttributedString(string: message)
                let range = (message as NSString).range(of: TextLabels.groupInfo_onlyOwner_move)
                attributedString.addAttribute(.font, value: Font.Typography.title4 as Any, range: range)
                
                let state = AlertState(contentLabel: attributedString,
                                       leftButtonLabel: TextLabels.groupInfo_button_cancel,
                                       rightButtonLabel: TextLabels.groupInfo_button_move)
                
                alert.setState(alertState: state)
                alert.setContentViewHeight(height: 234)
                
                alert.didTapConfirmButtonAction = { [weak self] in
                    self?.dismiss(animated: false)
                    let useCase = GroupUseCaseImpl(repository: GroupRepositoryImpl())
                    let playerUseCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
                    let memberUseCase = MemberUseCaseImpl(repository: MemberRepositoryImpl())
                    let reactor = GroupReactor(useCase: useCase, playerUseCase: playerUseCase, memberUseCase: memberUseCase)
                    let groupSettingViewController = GroupSettingViewController(reactor: reactor)
                    let navigationController = UINavigationController(rootViewController: groupSettingViewController)
                    navigationController.modalPresentationStyle = .overFullScreen
                    self?.present(navigationController, animated: false)
                }
                
                self?.present(alert, animated: false)
                
            default:
                // 멤버인 경우
                let alert = ConfirmPopupViewController()
                alert.modalPresentationStyle = .overFullScreen
                
                let groupName = self?.reactor?.currentState.groupInfoData?.name ?? ""
                let message = "\(TextLabels.groupInfo_message)\(groupName) \(TextLabels.groupInfo_exit_message)"
                let attributedString = NSMutableAttributedString(string: message)
                let range = (message as NSString).range(of: groupName)
                attributedString.addAttribute(.font, value: Font.Typography.title4 as Any, range: range)
                
                let state = AlertState(contentLabel: attributedString,
                                       leftButtonLabel: TextLabels.groupInfo_button_cancel,
                                       rightButtonLabel: TextLabels.groupInfo_button_exit)
                
                alert.setState(alertState: state)
                alert.setContentViewHeight(height: Metric.contentViewHeight)
                
                alert.didTapConfirmButtonAction = {
                    let groupId = GameDataSingleton.shared.getGroupId() ?? 0
                    Task {
                        self?.reactor?.action.onNext(.memberUnsubscribe(groupId: groupId))
                        AlertManager.show(message: "\(TextLabels.groupInfo_exit_alert)")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
                        
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let sceneDelegate = windowScene.delegate as? SceneDelegate {
                            sceneDelegate.window?.rootViewController = homeTabController
                        }
                    }
                }
                
                self?.present(alert, animated: false)
            }
            
        }), for: .touchUpInside)
        
        self.settingButton.addAction(UIAction(handler: { [weak self] _ in
            let useCase = GroupUseCaseImpl(repository: GroupRepositoryImpl())
            let playerUseCase = PlayerUseCasempl(repository: PlayerRepositoryImpl())
            let memberUseCase = MemberUseCaseImpl(repository: MemberRepositoryImpl())
            let reactor = GroupReactor(useCase: useCase, playerUseCase: playerUseCase, memberUseCase: memberUseCase)
            let groupSettingViewController = GroupSettingViewController(reactor: reactor)
            let navigationController = UINavigationController(rootViewController: groupSettingViewController)
            navigationController.modalPresentationStyle = .overFullScreen
            navigationController.transitioningDelegate = self
            self?.present(navigationController, animated: true)
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.dimmedView)
        self.view.addSubview(self.infoView)
        self.infoView.addSubview(self.nameLabel)
        self.infoView.addSubview(self.settingButton)
        self.infoView.addSubview(self.groupImageView)
        self.infoView.addSubview(self.descriptionLabel)
        self.infoView.addSubview(self.organizationLabel)
        self.infoView.addSubview(self.memberStackView)
        self.infoView.addSubview(self.memberNameLabel)
        self.infoView.addSubview(self.ownerStackView)
        self.infoView.addSubview(self.ownerNameLabel)
        self.infoView.addSubview(self.codeStackView)
        self.infoView.addSubview(self.copyStackView)
        self.infoView.addSubview(self.separatorView)
        self.infoView.addSubview(self.profileView)
        self.profileView.addSubview(self.profileDiceImage)
        self.profileView.addSubview(self.meStackView)
        self.profileView.addSubview(self.playCountLabel)
        self.profileView.addSubview(self.modifyButton)
        self.infoView.addSubview(self.divView)
        self.infoView.addSubview(self.exitStackView)
        
        self.dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.infoView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(2.3 / 3.0)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-Metric.leadingTrailingMargin)
        }
        
        self.settingButton.snp.makeConstraints {
            $0.width.height.equalTo(Metric.settingButtonSize)
            $0.top.equalTo(nameLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-Metric.leadingTrailingMargin)
        }
        
        self.groupImageView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
            $0.width.equalTo(Metric.imageViewWidth)
            $0.height.equalTo(Metric.imageViewHeight)
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leadingTrailingMargin)
        }
        
        self.organizationLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
        }
        
        self.memberStackView.snp.makeConstraints {
            $0.top.equalTo(organizationLabel.snp.bottom).offset(Metric.stackViewTopSpacing)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
        }
        
        self.memberNameLabel.snp.makeConstraints {
            $0.top.equalTo(memberStackView.snp.top)
            $0.leading.equalTo(memberStackView.snp.trailing).offset(Metric.leadingTrailingMargin)
        }
        
        self.ownerStackView.snp.makeConstraints {
            $0.top.equalTo(memberStackView.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
        }
        
        self.ownerNameLabel.snp.makeConstraints {
            $0.top.equalTo(ownerStackView.snp.top)
            $0.leading.equalTo(memberNameLabel.snp.leading)
        }
        
        self.codeImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.codeImageSize)
        }
        
        self.codeStackView.snp.makeConstraints {
            $0.top.equalTo(ownerStackView.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
        }
        
        self.copyStackView.snp.makeConstraints {
            $0.top.equalTo(codeStackView.snp.top)
            $0.leading.equalTo(memberNameLabel.snp.leading)
            $0.centerY.equalTo(codeStackView.snp.centerY)
        }
        
        self.separatorView.snp.makeConstraints {
            $0.top.equalTo(codeStackView.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leadingTrailingMargin)
            $0.height.equalTo(Metric.separatorViewHeight)
        }
        
        self.profileView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leadingTrailingMargin)
            $0.height.equalTo(Metric.profileViewHeight)
        }
        
        self.profileDiceImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.leadingTrailingMargin)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(Metric.diceImageSize)
        }
        
        self.meImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.meImageSize)
        }
        
        self.meStackView.snp.makeConstraints {
            $0.top.equalTo(Metric.meStackViewTopMargin)
            $0.leading.equalTo(profileDiceImage.snp.trailing).offset(Metric.itemSpacing)
        }
        
        self.playCountLabel.snp.makeConstraints {
            $0.top.equalTo(meStackView.snp.bottom).offset(Metric.countLabelTopSpacing)
            $0.leading.equalTo(meStackView.snp.leading)
        }
        
        self.modifyButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Metric.modifyButtonMargin)
        }
        
        self.divView.snp.makeConstraints {
            $0.bottom.equalTo(exitButton.snp.top).offset(-Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leadingTrailingMargin)
            $0.height.equalTo(Metric.separatorViewHeight)
        }
        
        self.exitImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.exitImageSize)
        }
        
        self.exitStackView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Metric.bottomMargin)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
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
    
    func configureGroupInfo(
        name: String,
        titleImage: UIImage,
        description: String,
        organization: String,
        memberCount: Int,
        owner: String,
        accessCode: String,
        nickname: String,
        playCount: Int
    ) {
        self.nameLabel.text = name
        self.groupImageView.image = titleImage
        self.descriptionLabel.text = description
        self.organizationLabel.text = organization
        self.memberNameLabel.text = "\(memberCount)\(TextLabels.group_memberCount)"
        self.ownerNameLabel.text = owner
        self.accessCodeLabel.text = accessCode
        self.nicknameLabel.text = nickname
        self.playCountLabel.text = "\(playCount)\(TextLabels.group_playCount)"
    }
}

extension GroupInfoDetailViewController {
    private func showMenu() {
        UIView.animate(withDuration: 0.5) {
            self.infoView.frame = CGRect(x: 0,
                                         y: self.infoView.frame.origin.y,
                                         width: self.view.frame.width,
                                         height: self.infoView.frame.height)
        }
    }
    
    private func hideMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.infoView.frame = CGRect(x: self.view.frame.width,
                                         y: self.infoView.frame.origin.y,
                                         width: self.infoView.frame.width,
                                         height: self.infoView.frame.height)
            self.dimmedView.alpha = 0.0
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}

extension GroupInfoDetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}
