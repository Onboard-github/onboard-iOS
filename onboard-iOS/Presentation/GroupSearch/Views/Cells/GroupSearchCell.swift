//
//  GroupSearchCell.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import UIKit
import Kingfisher

final class GroupSearchCell: UITableViewCell {
    // MARK: - Metric
    private enum Metric {
        static let titleTop = 24
        static let titleBottom = 4
        static let subTitleBottom = 16
        static let labelLeading = 20
        static let lableTrailing = 19
        static let infoLabelBottom = 18
        static let thumbnailTopTrailingBottom = 14
        
        enum Controls {
            static let stackTop = 26
            static let stackBottom = 24
        }
    }
    
    // MARK: - UI
    let cornerBackgroundView: UIView = {
        let view = RoundedView()
        view.backgroundColor = .white
        view.cornerRadius = 12
        view.borderWidth = 1
        view.borderColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "보드게임 동아리 이름"
        label.font = Font.Typography.title3
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 보드게임 동아리는 이런 곳입니다 한줄...................."
        label.font = Font.Typography.body4_R
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "00명"
        label.font = Font.Typography.body5_R
        label.textColor = .lightGray
        return label
    }()
    
    let secondInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "XX대학교"
        label.font = Font.Typography.body5_R
        label.textColor = .lightGray
        return label
    }()
    
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.kf.indicatorType = .activity
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    private func configure() {
        self.makeConstraints()
        selectionStyle = .none
    }
    
    private func makeConstraints() {
        self.addSubview(self.cornerBackgroundView)
        cornerBackgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        cornerBackgroundView.addSubview(self.thumbnailView)
        cornerBackgroundView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(Metric.titleTop)
            make.leading.equalToSuperview().inset(Metric.labelLeading)
            make.trailing.equalTo(thumbnailView.snp.leading).offset(-Metric.lableTrailing)
        }
        
        cornerBackgroundView.addSubview(self.subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.titleBottom)
            make.leading.equalToSuperview().inset(Metric.labelLeading)
            make.trailing.equalTo(thumbnailView.snp.leading).offset(-Metric.lableTrailing)
        }

        cornerBackgroundView.addSubview(self.infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Metric.labelLeading)
            make.bottom.equalToSuperview().inset(Metric.infoLabelBottom)
        }
        
        thumbnailView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(Metric.thumbnailTopTrailingBottom)
            make.height.equalTo(82)
            make.width.equalTo(62)
        }
    }
}

