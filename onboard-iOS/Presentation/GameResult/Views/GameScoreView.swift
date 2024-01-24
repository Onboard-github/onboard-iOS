//
//  GameScoreView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/25/24.
//

import UIKit

final class GameScoreView: UIView {
    
    // MARK: - UI
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.tintColor = Colors.Orange_5
        bar.trackTintColor = Colors.Orange_1
        bar.progress = 19.0 / 20.0
        return bar
    }()
    
    private let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.calendarLine1.image
        imageView.image = image
        return imageView
    }()
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TextLabels.game_record_calendar
        
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        label.text = formattedDate
        
        return label
    }()
    
    private let timeIcon: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.timeLine1.image
        imageView.image = image
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = TextLabels.game_record_time
        
        let currentTime = Date()
        let formattedTime = timeFormatter.string(from: currentTime)
        label.text = formattedTime
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = GameDataSingleton.shared.gameData.map { "\($0.name) \(TextLabels.game_record_title_info)" }
        label.textColor = Colors.Gray_13
        label.font = Font.Typography.body2_M
        return label
    }()
    
    private lazy var playerTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 60
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.register(GameScoreTableViewCell.self,
                      forCellReuseIdentifier: "GameScoreTableViewCell")
        return view
    }()
}
