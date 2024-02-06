//
//  ResultRecordView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/6/24.
//

import UIKit

final class ResultRecordView: UIView {
    
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
}
