//
//  GroupInfoDetailView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/16/24.
//

import UIKit

final class GroupInfoDetailView: UIView {
    
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
    }
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_1
        view.layer.cornerRadius = 0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
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
        self.addSubview(self.infoView)
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
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.infoView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            $0.width.equalToSuperview().multipliedBy(2.3 / 3.0)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
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
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-Metric.topMargin)
            $0.leading.equalToSuperview().offset(Metric.leadingTrailingMargin)
        }
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
