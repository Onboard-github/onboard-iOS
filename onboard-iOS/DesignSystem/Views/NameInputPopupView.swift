//
//  NameInputPopupView.swift
//  onboard-iOS
//
//  Created by 혜리 on 12/10/23.
//

import UIKit

import ReactorKit

import RxSwift
import RxCocoa

final class NameInputPopupView: UIViewController, View {
    
    typealias Reactor = GroupCreateReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
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
        label.text = TextLabels.owner_popup_title
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.owner_popup_subTitle
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        return label
    }()
    
    private let textField: TextField = {
        let textField = TextField()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: Metric.iconSize + 10, height: Metric.iconSize))
        let textFieldImage = UIImageView(image: IconImage.manager.image)
        textField.textColor = Colors.Gray_15
        textField.font = Font.Typography.body2_M
        
        textFieldImage.frame = CGRect(x: 10, y: 0, width: Metric.iconSize, height: Metric.iconSize)
        leftView.addSubview(textFieldImage)
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.becomeFirstResponder()
        return textField
    }()
    
    private let textFieldSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.owner_popup_textFieldSubTitle
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.owner_popup_count
        label.textColor = Colors.Gray_8
        label.font = Font.Typography.body5_R
        return label
    }()
    
    private let registerButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .bottom)
        button.setTitle(TextLabels.owner_popup_register, for: .normal)
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
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    // MARK: - Initialize
    
    init(reactor: GroupCreateReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bind(reactor: GroupCreateReactor) {
        self.bindAction(reactor: reactor)
    }
    
    func bindAction(reactor: GroupCreateReactor) {
        self.registerButton.addAction(UIAction { [weak self] _ in
            self?.view.endEditing(true)
            self?.contentView.isHidden = true
            self?.loadingView.showOnlyIndicator()
            self?.loadingView.setLabel(
                loadingText: TextLabels.game_record_recording
            )
            self?.loadingView.isLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.loadingView.isLoading = false
                
                let req = GroupCreateCompleteEntity.Req(
                    name: GroupCreateSingleton.shared.nameText.value,
                    description: GroupCreateSingleton.shared.descriptionText.value,
                    organization: GroupCreateSingleton.shared.organizationText.value,
                    profileImageUrl: nil,
                    profileImageUuid: GroupCreateSingleton.shared.groupImageUuid.value,
                    nickname: LoginSessionManager.getNickname() ?? ""
                )
                
                self?.reactor?.action.onNext(.createGroups(req: req))
                
                let completeVC = GroupCreateCompleteViewController()
                completeVC.modalPresentationStyle = .overFullScreen
                self?.present(completeVC, animated: false)
            }
        }, for: .touchUpInside)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.makeConstraints()
        self.setupGestureRecognizer()
        
        self.setupTextField()
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.titleStackView)
        self.contentView.addSubview(self.textFieldStackView)
        self.contentView.addSubview(self.registerButton)
        
        self.backgroundView.addSubview(self.loadingView)
        
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
        
        self.loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.backgroundView.addGestureRecognizer(tapGesture)
        self.backgroundView.isUserInteractionEnabled = true
    }
    
    @objc
    private func backgroundTapped() {
        self.dismiss(animated: false)
    }
}

// MARK: - TextField

extension NameInputPopupView: UITextViewDelegate {
    
    private func setupTextField() {
        self.textField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                let maxLength = 14
                let updatedText = String(text.prefix(maxLength))
                self?.countLabel.text = "\(String(format: "%02d", updatedText.count))/\(maxLength)"
                self?.textField.text = (text.count > maxLength) ? String(text.prefix(maxLength)) : text
                
                self?.setButtonStatus(text: updatedText)
                
                GroupCreateSingleton.shared.ownerText.accept(text)
            })
            .disposed(by: disposeBag)
    }
    
    private func setButtonStatus(text: String) {
        self.registerButton.status = text.isEmpty ? .disabled : .default
    }
}
