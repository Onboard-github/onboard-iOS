//
//  ImagePopupView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/19.
//

import UIKit

class ImagePopupView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let contentViewWidth: CGFloat = 324
        static let contentViewHeight: CGFloat = 200
        static let topMargin: CGFloat = 26
        static let bottomMargin: CGFloat = 20
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 대표 이미지"
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임을 소개하는 대표 이미지를 넣어보세요!"
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        label.numberOfLines = 0
        return label
    }()
    
    private let imageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("앨범에서 사진 선택", for: .normal)
        button.setTitleColor(Colors.Gray_14, for: .normal)
        button.titleLabel?.font = Font.Typography.body2_R
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let randomImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("랜덤 이미지", for: .normal)
        button.setTitleColor(Colors.Gray_14, for: .normal)
        button.titleLabel?.font = Font.Typography.body2_R
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel,
                                                  subTitleLabel])
        view.spacing = 5
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageButton,
                                                  randomImageButton])
        view.spacing = 10
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
        self.contentView.addSubview(self.buttonStackView)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(Metric.contentViewWidth)
            $0.height.equalTo(Metric.contentViewHeight)
        }
        
        self.titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRigntMargin)
        }
        
        self.buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Metric.bottomMargin)
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
