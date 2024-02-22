//
//  SearchEmptyStateView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/22/24.
//

import UIKit

final class SearchEmptyStateView: UIView {
    
    var didTapButton: (() -> Void)?
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_11
        label.font = Font.Typography.body2_M
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.search_empty_subTitle
        label.textColor = Colors.Gray_10
        label.font = Font.Typography.body3_R
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addGuest"), for: .normal)
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
        self.backgroundColor = Colors.White
        
        self.addConfigure()
        self.makeConstraints()
    }
    
    private func addConfigure() {
        self.addButton.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapButton?()
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.addButton)
        
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(150)
        }
        
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.addButton.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
}
