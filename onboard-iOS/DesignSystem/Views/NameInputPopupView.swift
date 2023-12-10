//
//  NameInputPopupView.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/10/23.
//

import UIKit

final class NameInputPopupView: UIView {
    
    // MARK: - Metric
    
    private enum Metric {
        static let iconSize: CGFloat = 18
        static let contentViewLeftRightMargin: CGFloat = 20
        static let contentViewHeight: CGFloat = 228
        static let topMargin: CGFloat = 26
        static let leftRightMargin: CGFloat = 24
        static let textFieldHeight: CGFloat = 52
        static let itemSpacing: CGFloat = 20
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "관리자 프로필 설정"
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "그룹에서 사용할 닉네임을 10자 이하로 입력해주세요."
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private lazy var textField: TextField = {
        let textField = TextField()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: Metric.iconSize + 10, height: Metric.iconSize))
        let textFieldImage = UIImageView(image: IconImage.manager.image)
        textField.textColor = Colors.Gray_15
        textField.font = Font.Typography.body2_M
        
        textFieldImage.frame = CGRect(x: 10, y: 0, width: Metric.iconSize, height: Metric.iconSize)
        leftView.addSubview(textFieldImage)
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let textFieldSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "한글, 영문, 숫자를 조합하여 사용 가능합니다."
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "00/10"
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let registerButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .bottom)
        button.setTitle("그룹 등록하기", for: .normal)
        return button
    }()
    
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel,
                                                  subTitleLabel])
        view.spacing = 8
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [textField,
                                                  bottomStackView])
        view.spacing = 2
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [textFieldSubTitleLabel,
                                                  countLabel])
        view.spacing = 10
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        return view
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
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.titleStackView)
        self.contentView.addSubview(self.textFieldStackView)
        self.contentView.addSubview(self.registerButton)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.contentViewLeftRightMargin)
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(Metric.contentViewHeight)
        }
        
        self.titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.textField.snp.makeConstraints {
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(Metric.itemSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(Metric.itemSpacing)
            $0.bottom.leading.trailing.equalToSuperview()
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
    
    @objc
    private func backgroundTapped() {
        removeFromSuperview()
    }
}
