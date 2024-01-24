//
//  GameScoreView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/25/24.
//

import UIKit

final class GameScoreView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let iconSize: CGFloat = 16
        static let progressBarHeight: CGFloat = 2
        static let labelTopSpacing: CGFloat = 15
        static let leftRightMargin: CGFloat = 20
        static let labelLeading: CGFloat = 5
        static let iconLeading: CGFloat = 10
        static let tableViewTopSpacing: CGFloat = 30
    }
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = Colors.White
        
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.addSubview(self.progressBar)
        self.addSubview(self.calendarIcon)
        self.addSubview(self.calendarLabel)
        self.addSubview(self.timeIcon)
        self.addSubview(self.timeLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.playerTableView)
        
        self.progressBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.progressBarHeight)
        }
        
        self.calendarIcon.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.calendarLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalTo(calendarIcon.snp.trailing).offset(Metric.labelLeading)
        }
        
        self.timeIcon.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalTo(calendarLabel.snp.trailing).offset(Metric.iconLeading)
        }
        
        self.timeLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalTo(timeIcon.snp.trailing).offset(Metric.labelLeading)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(calendarIcon.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.playerTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.tableViewTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
