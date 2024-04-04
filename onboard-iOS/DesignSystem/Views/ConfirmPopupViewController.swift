//
//  ConfirmPopupViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/2/24.
//

import UIKit

final class ConfirmPopupViewController: UIViewController {
    
    // MARK: - Properties
    
    var didTapConfirmButtonAction: (() -> Void)?
    
    // MARK: - Metric
    
    private enum Metric {
        static let basePadding: CGFloat = 24
        static let contentLabelTopMargin: CGFloat = 30
        static let buttonTopSpacing: CGFloat = 20
        static let buttonHeight: CGFloat = 52
        static let buttonWidth: CGFloat = 0.5
    }
    
    // MARK: - UI
    
    private let dimmedView: UIView = {
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
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.Orange_10, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_B
        button.backgroundColor = Colors.Gray_2
        return button
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.Gray_1, for: .normal)
        button.titleLabel?.font = Font.Typography.label3_B
        button.backgroundColor = Colors.Orange_10
        return button
    }()
    
    // MARK: - Initialize
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        
        self.addConfigure()
        self.makeConstraints()
        self.setupGestureRecognizer()
    }
    
    private func addConfigure() {
        self.cancelButton.addAction(UIAction(handler: { [weak self] _ in
            self?.dismiss(animated: false)
        }), for: .touchUpInside)
        
        self.confirmButton.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapConfirmButtonAction?()
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.dimmedView)
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.cancelButton)
        self.contentView.addSubview(self.confirmButton)
        
        self.dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.basePadding)
            $0.centerY.equalToSuperview()
        }
        
        self.contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.contentLabelTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.basePadding)
        }
        
        self.cancelButton.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(Metric.buttonTopSpacing)
            $0.bottom.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Metric.buttonWidth)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(Metric.buttonTopSpacing)
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Metric.buttonWidth)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    private func setupGestureRecognizer() {
        let dimmedTap = UITapGestureRecognizer(
            target: self,
            action: #selector(dimmedViewAction(_:))
        )
        
        self.dimmedView.addGestureRecognizer(dimmedTap)
        self.dimmedView.isUserInteractionEnabled = true
    }
    
    @objc
    private func dimmedViewAction(_ tapRecognizer: UITapGestureRecognizer)  {
        self.dismiss(animated: false)
    }
    
    func setState(alertState: AlertState) {
        self.contentLabel.attributedText = alertState.contentLabel
        self.cancelButton.setTitle(alertState.leftButtonLabel, for: .normal)
        self.confirmButton.setTitle(alertState.rightButtonLabel, for: .normal)
    }
    
    func setContentViewHeight(height: CGFloat) {
        self.contentView.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
