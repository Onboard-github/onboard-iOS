//
//  ImagePopupViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/19.
//

import UIKit

import ReactorKit

final class ImagePopupViewController: UIViewController, View {
    
    typealias Reactor = GroupCreateReactor
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    var imageCompletion: ((UIImage?) -> Void)?
    private let imagePickerController = UIImagePickerController()
    
    // MARK: - Metric
    
    private enum Metric {
        static let contentViewLRMargin: CGFloat = 20
        static let contentViewWidth: CGFloat = 324
        static let contentViewHeight: CGFloat = 200
        static let topMargin: CGFloat = 26
        static let bottomMargin: CGFloat = 20
        static let leftRightMargin: CGFloat = 24
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
        label.text = TextLabels.image_popup_title
        label.textColor = Colors.Gray_15
        label.font = Font.Typography.title2
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.image_popup_subTitle
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        label.numberOfLines = 0
        return label
    }()
    
    private let imageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(TextLabels.image_popup_fileUpload, for: .normal)
        button.setTitleColor(Colors.Gray_14, for: .normal)
        button.titleLabel?.font = Font.Typography.body2_R
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let randomImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(TextLabels.image_popup_random, for: .normal)
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
        self.bindState(reactor: reactor)
    }
    
    func bindAction(reactor: GroupCreateReactor) {
        self.imageButton.addAction(UIAction(handler: { [self] _ in
            openImagePicker()
        }), for: .touchUpInside)
        
        self.randomImageButton.addAction(UIAction { [weak self] _ in
            self?.reactor?.action.onNext(.randomImage)
        }, for: .touchUpInside)
    }
    
    func bindState(reactor: GroupCreateReactor) {
        reactor.state
            .map { $0.imageURL }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                ImageLoader.loadImage(from: data) { image in
                    self?.imageCompletion?(image)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.makeConstraints()
        self.setupGestureRecognizer()
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.titleStackView)
        self.contentView.addSubview(self.buttonStackView)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.contentViewLRMargin)
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(Metric.contentViewHeight)
        }
        
        self.titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Metric.bottomMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func createFile(from image: UIImage, withName name: String, mimeType: String) -> File? {
        guard let imageData = image.pngData() else { return nil }
        
        return File(name: name, data: imageData, mimeType: mimeType)
    }
    
    @objc
    private func backgroundTapped() {
        self.dismiss(animated: false)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ImagePopupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = false
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let file = createFile(from: image, withName: "image.png", mimeType: "image/png") {

                reactor?.action.onNext(.fileUpload(file: file, purpose: .MATCH_IMAGE))
            }
            imageCompletion?(image)
        }

        picker.dismiss(animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}
