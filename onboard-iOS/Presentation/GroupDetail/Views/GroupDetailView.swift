//
//  GroupDetailView.swift
//  onboard-iOS
//
//  Created by main on 2023/10/20.
//

import UIKit
import SnapKit

final class GroupDetailView: UIView {
    
    // MARK: - Metric
    private enum Metric {
        static let labelSide = 24
        static let titleGap = 8
        
        enum BackButton {
            static let top = 16
            static let leading = 18
        }
        
        enum ConfirmButton {
            static let side = 18
            static let bottom = 26
        }
        
        enum GameView {
            static let top = 36
            static let trailing = 24
            static let bottom = 30
        }
    }
    
    // MARK: - UI
    var backButton: UIButton = {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        return button
    }()
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("모임 등록하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.contentEdgeInsets.top = 14
        button.contentEdgeInsets.bottom = 14
        button.backgroundColor = UIColor(red: 255/255.0, green: 77/255.0, blue: 13/255.0, alpha: 1)
        return button
    }()
    
    var gamesBackView: UIView = {
        let gameView = UIView()
        gameView.backgroundColor = .darkGray
        gameView.snp.makeConstraints { make in
            make.width.equalTo(146)
            make.height.equalTo(90)
        }
        return gameView
    }()
    
    var topLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "홍익대학교"
        label.textColor = UIColor(red: 251/255.0, green: 251/255.0, blue: 251/255.0, alpha: 1)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "동아리이름동아리이름동아리이름동아리이름동아리이"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 251/255.0, green: 251/255.0, blue: 251/255.0, alpha: 1)
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아리소개동아"
        label.numberOfLines = 0
        label.textColor = UIColor(red: 251/255.0, green: 251/255.0, blue: 251/255.0, alpha: 1)
        return label
    }()
    
    var membersView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    var ownerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    private func configure() {
        self.backgroundColor = .gray
        makeConstraints()
    }
    
    private func makeConstraints() {
        self.addSubview(self.backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(Metric.BackButton.top)
            make.leading.equalToSuperview().inset(Metric.BackButton.leading)
        }
        
        self.addSubview(self.confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Metric.ConfirmButton.side)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(Metric.ConfirmButton.bottom)
        }
        
        self.addSubview(gamesBackView)
        gamesBackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Metric.GameView.trailing)
            make.bottom.equalTo(confirmButton.snp.top).offset(-Metric.GameView.bottom)
        }
        
        self.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(gamesBackView.snp.top).offset(-Metric.GameView.top)
            make.leading.trailing.equalToSuperview().inset(Metric.labelSide)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-Metric.titleGap)
            make.leading.trailing.equalToSuperview().inset(Metric.labelSide)
        }
        
        self.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-Metric.titleGap)
            make.leading.trailing.equalToSuperview().inset(Metric.labelSide)
        }
        
        self.addSubview(membersView)
        membersView.snp.makeConstraints { make in
            make.top.equalTo(gamesBackView)
            make.leading.equalToSuperview().inset(Metric.labelSide)
            make.trailing.equalTo(gamesBackView.snp.leading).offset(-Metric.labelSide)
            make.height.equalTo(30)
        }
        
        self.addSubview(ownerView)
        ownerView.snp.makeConstraints { make in
            make.top.equalTo(membersView.snp.bottom).offset(Metric.titleGap)
            make.leading.equalToSuperview().inset(Metric.labelSide)
            make.trailing.equalTo(gamesBackView.snp.leading).offset(-Metric.labelSide)
            make.height.equalTo(30)
        }
    }
}
