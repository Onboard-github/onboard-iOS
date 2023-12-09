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
}
