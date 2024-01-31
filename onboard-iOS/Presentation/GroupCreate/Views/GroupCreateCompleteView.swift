//
//  GroupCreateCompleteView.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/21/23.
//

import UIKit
import RxSwift
import RxCocoa

final class GroupCreateCompleteView: UIView {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    // MARK: - Metric
    
    enum Metric {
        static let topMargin: CGFloat = 80
        static let titleTopMarin: CGFloat = 40
        static let leftRightMargin: CGFloat = 24
        static let imageSize: CGFloat = 18
        static let ownerLeadingSpacing: CGFloat = 25
        static let copyImageSize: CGFloat = 16
        static let itemSpacing: CGFloat = 15
        static let inviteBottomSpacing: CGFloat = 130
        static let buttonBottomMargin: CGFloat = 70
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let completeLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_complete_text
        label.textColor = Colors.Orange_8
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.headLine
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.body3_R
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
        label.textColor = Colors.Gray_7
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.title3
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
        label.textColor = Colors.Gray_7
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let accessCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_2
        label.font = Font.Typography.title3
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        let image = IconImage.copy
        button.setImage(image.image, for: .normal)
        return button
    }()
    
    private let inviteLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.group_invite_text
        label.textColor = Colors.Orange_5
        label.font = Font.Typography.body4_R
        label.numberOfLines = 0
        return label
    }()
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .default, style: .rounded)
        button.setTitle(TextLabels.confirm_text, for: .normal)
        return button
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [organizationLabel, nameLabel, descriptionLabel])
        stview.axis = .vertical
        stview.spacing = 7
        return stview
    }()
    
    private lazy var managerStackView: UIStackView = {
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
        self.addConfigure()
        self.makeConstraints()
        self.getCreateData()
    }
    
    private func addConfigure() {
        self.copyButton.addAction(UIAction(handler: { [weak self] _ in
            let pasteboard = UIPasteboard.general
            pasteboard.string = self?.accessCodeLabel.text
        }), for: .touchUpInside)
        
        self.confirmButton.addAction(UIAction(handler: { [weak self] _ in
            self?.findViewController()?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.addSubview(self.backgroundImage)
        
        self.backgroundImage.addSubview(self.completeLabel)
        
        self.backgroundImage.addSubview(self.titleStackView)
        
        self.backgroundImage.addSubview(self.managerStackView)
        self.backgroundImage.addSubview(self.ownerNameLabel)
        
        self.backgroundImage.addSubview(self.codeStackView)
        self.backgroundImage.addSubview(self.copyStackView)
        
        self.backgroundImage.addSubview(self.inviteLabel)
        self.backgroundImage.addSubview(self.confirmButton)
        
        self.backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.completeLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Metric.topMargin)
            $0.centerX.equalToSuperview()
        }
        
        self.titleStackView.snp.makeConstraints {
            $0.top.equalTo(completeLabel.snp.bottom).offset(Metric.titleTopMarin)
            $0.leading.equalTo(Metric.leftRightMargin)
        }
        
        self.ownerImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.imageSize)
        }
        
        self.ownerNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(managerStackView.snp.centerY)
            $0.leading.equalTo(managerStackView.snp.trailing).offset(Metric.ownerLeadingSpacing)
        }
        
        self.managerStackView.snp.makeConstraints {
            $0.bottom.equalTo(codeStackView.snp.top).offset(-Metric.itemSpacing)
            $0.leading.equalTo(Metric.leftRightMargin)
        }
        
        self.codeImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.imageSize)
        }
        
        self.copyButton.snp.makeConstraints {
            $0.width.height.equalTo(Metric.copyImageSize)
        }
        
        self.codeStackView.snp.makeConstraints {
            $0.bottom.equalTo(inviteLabel.snp.top).offset(-Metric.itemSpacing)
            $0.leading.equalTo(Metric.leftRightMargin)
        }
        
        self.copyStackView.snp.makeConstraints {
            $0.centerY.equalTo(codeStackView.snp.centerY)
            $0.leading.equalTo(ownerNameLabel)
        }
        
        self.inviteLabel.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top).offset(-Metric.inviteBottomSpacing)
            $0.leading.equalTo(Metric.leftRightMargin)
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-Metric.buttonBottomMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    private func getCreateData() {
        GroupCreateSingleton.shared.organizationText
            .subscribe(onNext: { [weak self] text in
                self?.organizationLabel.text = text
            })
            .disposed(by: disposeBag)
        
        GroupCreateSingleton.shared.nameText
            .subscribe(onNext: { [weak self] text in
                self?.nameLabel.text = text
            })
            .disposed(by: disposeBag)
        
        GroupCreateSingleton.shared.descriptionText
            .subscribe(onNext: { [weak self] text in
                self?.descriptionLabel.text = text
            })
            .disposed(by: disposeBag)
        
    }
}
