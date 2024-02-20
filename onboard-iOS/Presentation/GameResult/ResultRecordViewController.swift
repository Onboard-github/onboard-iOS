//
//  ResultRecordViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/6/24.
//

import UIKit

import ReactorKit

final class ResultRecordViewController: UIViewController, View {
    
    typealias Reactor = MatchReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    
    private let resultRecordView = ResultRecordView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = resultRecordView
    }
    
    // MARK: - Initialize
    
    init(reactor: MatchReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind(reactor: MatchReactor) {
        self.bindAction(reactor: reactor)
    }
    
    func bindAction(reactor: MatchReactor) {
        resultRecordView.didTapCloseButtonAction = { [weak self] in
            self?.dismiss(animated: false)
        }
        
        resultRecordView.didTapRegisterButtonAction = { [weak self] in
            
            let selectedPlayers = GameDataSingleton.shared.selectedPlayerData
            
            let matchMembers: [MatchRequest.Body.Match] = selectedPlayers.enumerated().map { (index, player) in
                return MatchRequest.Body.Match(memberId: index + 1, score: Int(player.score!)!, ranking: index + 1)
            }
            
            let req = MatchEntity.Req(
                gameId: GameDataSingleton.shared.gameData?.id ?? 0,
                groupId: GameDataSingleton.shared.getGroupId() ?? 0,
                matchedDate: "\(GameDataSingleton.shared.calendarText.value) \(GameDataSingleton.shared.timeText.value)",
                matchMembers: matchMembers
            )
            
            self?.reactor?.action.onNext(.recordMatch(req: req))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeTabController = storyboard.instantiateViewController(identifier: "homeTabController")
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = homeTabController
                }
            }
        }
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.setupGestureRecognizer()
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func backgroundTapped() {
        self.dismiss(animated: false)
    }
}
