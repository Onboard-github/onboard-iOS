//
//  GameScoreViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/25/24.
//

import UIKit

final class GameScoreViewController: UIViewController {
    
    // MARK: - Properties
    
    private let gameScoreView = GameScoreView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = gameScoreView
    }
}
