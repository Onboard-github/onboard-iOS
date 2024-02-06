//
//  ResultRecordView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/6/24.
//

import UIKit

final class ResultRecordView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let contentViewLRMargin: CGFloat = 20
        static let contentViewHeight: CGFloat = 452
        static let gameImageTopMargin: CGFloat = 30
        static let gameImageWidth: CGFloat = 40
        static let gameImageHeight: CGFloat = 50
        static let gameLabelTopMargin: CGFloat = 35
        static let gameLabelLeadingSpacing: CGFloat = 15
        static let stackViewLeadingSpacing: CGFloat = 10
        static let closeButtonTopMargin: CGFloat = 20
        static let closeButtonTrailingMargin: CGFloat = 30
        static let playViewTrailingMargin: CGFloat = 20
        static let playViewWidth: CGFloat = 72
        static let playViewHeight: CGFloat = 22
        static let tableViewTBMargin: CGFloat = 30
        static let tableViewLRMargin: CGFloat = 20
        static let guideLabelSpacing: CGFloat = 20
        static let registerButtonHeight: CGFloat = 52
    }
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let gameImage: UIImageView = {
        let imageView = UIImageView()
        if let imageUrl = GameDataSingleton.shared.gameData?.img {
            ImageLoader.loadImage(from: imageUrl) { image in
                imageView.image = image
            }
        }
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gameLabel: UILabel = {
        let label = UILabel()
        label.text = GameDataSingleton.shared.gameData?.name
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.title3
        return label
    }()
    
    private let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.calendarLine1.image
        imageView.image = image
        return imageView
    }()
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_12
        label.font = Font.Typography.body4_R
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
        label.textColor = Colors.Gray_12
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(IconImage.X_gray.image, for: .normal)
        return button
    }()
    
    private let playView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Orange_2
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let playLabel: UIView = {
        let label = UILabel()
        label.text = "\(GameDataSingleton.shared.selectedPlayerData.count)\(TextLabels.game_record_player_count)"
        label.textColor = Colors.Gray_12
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private lazy var resultRecordTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 44
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.register(ResultRecordTableViewCell.self,
                      forCellReuseIdentifier: "ResultRecordTableViewCell")
        return view
    }()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.game_record_guide
        label.textColor = Colors.Orange_10
        label.font = Font.Typography.body4_R
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let registerButton: BaseButton = {
        let button = BaseButton(status: .default, style: .bottom)
        button.setTitle(TextLabels.game_record_register, for: .normal)
        return button
    }()
    
    private lazy var calendarStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [calendarIcon,
                                                    calendarLabel])
        stview.axis = .horizontal
        stview.spacing = 2
        return stview
    }()
    
    private lazy var timeStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [timeIcon,
                                                    timeLabel])
        stview.axis = .horizontal
        stview.spacing = 2
        return stview
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.contentView)
        self.contentView.addSubview(self.gameImage)
        self.contentView.addSubview(self.gameLabel)
        self.contentView.addSubview(self.calendarStackView)
        self.contentView.addSubview(self.timeStackView)
        self.contentView.addSubview(self.closeButton)
        self.contentView.addSubview(self.playView)
        self.playView.addSubview(self.playLabel)
        self.contentView.addSubview(self.resultRecordTableView)
        self.contentView.addSubview(self.guideLabel)
        self.contentView.addSubview(self.registerButton)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.contentViewLRMargin)
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(Metric.contentViewHeight)
        }
        
        self.gameImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Metric.gameImageTopMargin)
            $0.width.equalTo(Metric.gameImageWidth)
            $0.height.equalTo(Metric.gameImageHeight)
        }
        
        self.gameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.gameLabelTopMargin)
            $0.leading.equalTo(gameImage.snp.trailing).offset(Metric.gameLabelLeadingSpacing)
        }
        
        self.calendarStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.gameImage)
            $0.leading.equalTo(gameImage.snp.trailing).offset(Metric.gameLabelLeadingSpacing)
        }
        
        self.timeStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.gameImage)
            $0.leading.equalTo(calendarStackView.snp.trailing).offset(Metric.stackViewLeadingSpacing)
        }
        
        self.closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.closeButtonTopMargin)
            $0.trailing.equalToSuperview().inset(Metric.closeButtonTrailingMargin)
        }
        
        self.playView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Metric.playViewTrailingMargin)
            $0.bottom.equalTo(self.gameImage)
            $0.width.equalTo(Metric.playViewWidth)
            $0.height.equalTo(Metric.playViewHeight)
        }
        
        self.playLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.resultRecordTableView.snp.makeConstraints {
            $0.top.equalTo(gameImage.snp.bottom).offset(Metric.tableViewTBMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.tableViewLRMargin)
            $0.bottom.equalTo(guideLabel.snp.top).offset(-Metric.tableViewTBMargin)
        }
        
        self.guideLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.guideLabelSpacing)
            $0.bottom.equalTo(registerButton.snp.top).offset(-Metric.guideLabelSpacing)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.registerButtonHeight)
        }
    }
}
