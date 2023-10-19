//
//  JoinPopupView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/19.
//

import UIKit

class JoinPopupView: UIView {
    
    // MARK: - Metric

    private enum Metric {
        static let contentViewWidth: CGFloat = 324
        static let contentViewHeight: CGFloat = 176
        static let topMargin: CGFloat = 26
        static let leftRigntMargin: CGFloat = 24
        static let iconSize: CGFloat = 20
        static let textFieldHeight: CGFloat = 52
    }
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let titleImage: UIImageView = {
        let image = UIImageView()
        let iconImage = IconImage.code
        image.image = iconImage.image
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 코드 입력"
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 참여 코드를 입력해주세요"
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        label.numberOfLines = 0
        return label
    }()
    
    private let textField: TextField = {
        let text = TextField()
        text.textColor = Colors.Gray_15
        text.font = Font.Typography.body2_M
        return text
    }()
    
    private let textFieldSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Red
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleImage,
                                                  titleLabel])
        view.spacing = 8
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [textField,
                                                  textFieldSubTitleLabel])
        view.spacing = 2
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        makeConstraints()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func makeConstraints() {
        self.addSubview(self.backgroundView)
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.titleStackView)
        self.contentView.addSubview(self.subTitleLabel)
        self.contentView.addSubview(self.textFieldStackView)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(Metric.contentViewWidth)
            $0.height.equalTo(Metric.contentViewHeight)
        }
        
        self.titleImage.snp.makeConstraints {
            $0.width.height.equalTo(Metric.iconSize)
        }
        
        self.titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRigntMargin)
        }
        
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRigntMargin)
        }
        
        self.textField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRigntMargin)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func backgroundTapped() {
        removeFromSuperview()
    }
}
