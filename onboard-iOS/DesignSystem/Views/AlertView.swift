//
//  AlertView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class AlertView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let LRMargin: CGFloat = 24
        static let contentViewHeight: CGFloat = 216
        static let labelTopMargin: CGFloat = 30
        static let buttonTopMargin: CGFloat = 20
        static let buttonHeight: CGFloat = 52
    }
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.White
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_13
        label.font = Font.Typography.body3_R
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.Orange_10, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_B
        button.backgroundColor = Colors.Gray_2
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.Gray_1, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_B
        button.backgroundColor = Colors.Orange_10
        return button
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
        self.setupGestureRecognizer()
    }
    
    private func makeConstraints() {
        self.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.contentView)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.leftButton)
        self.contentView.addSubview(self.rightButton)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.LRMargin)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(Metric.contentViewHeight)
        }
        
        self.contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.labelTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.LRMargin)
        }
        
        self.leftButton.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(Metric.buttonTopMargin)
            $0.bottom.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        self.rightButton.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(Metric.buttonTopMargin)
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    func setAlertState(alertState: AlertState,
                       onClicked: @escaping (() -> Void)) {
        
        self.contentLabel.attributedText = alertState.contentLabel
        self.leftButton.setTitle(alertState.leftButtonLabel, for: .normal)
        self.rightButton.setTitle(alertState.rightButtonLabel, for: .normal)
    }
    
    @objc
    private func backgroundTapped() {
        removeFromSuperview()
    }
}
