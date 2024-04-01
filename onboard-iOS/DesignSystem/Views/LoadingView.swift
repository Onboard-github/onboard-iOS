//
//  LoadingView.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/6/24.
//

import UIKit

final class LoadingView: UIView {
    
    // MARK: - Properties
    
    var isLoading = false {
        didSet {
            self.isHidden = !self.isLoading
            self.isLoading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Metric
    
    enum Metric {
        static let labelBottomSpacing: CGFloat = 20
        static let imageSize: CGFloat = 224
    }
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Orange_10
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = Colors.Orange_10
        return view
    }()
    
    private let loadingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: GifURL.url))
        return imageView
    }()
    
    private let loadingImageLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Orange_10
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let completeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.White
        label.font = Font.Typography.title1
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
    }
    
    private func makeConstraints() {
        self.addSubview(self.backgroundView)
        self.addSubview(self.loadingLabel)
        self.addSubview(self.activityIndicatorView)
        self.addSubview(self.loadingImage)
        self.addSubview(self.loadingImageLabel)
        self.addSubview(self.completeLabel)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.loadingLabel.snp.makeConstraints {
            $0.bottom.equalTo(activityIndicatorView.snp.top).offset(-Metric.labelBottomSpacing)
            $0.centerX.equalToSuperview()
        }
        
        self.activityIndicatorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.loadingImage.snp.makeConstraints {
            $0.bottom.equalTo(loadingImageLabel.snp.top).offset(Metric.labelBottomSpacing)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(Metric.imageSize)
        }
        
        self.loadingImageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.completeLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func showOnlyIndicator() {
        self.loadingLabel.isHidden = false
        self.activityIndicatorView.isHidden = false
        self.loadingImage.isHidden = true
        self.loadingImageLabel.isHidden = true
        self.completeLabel.isHidden = true
    }
    
    func showIndicator() {
        self.loadingLabel.isHidden = false
        self.activityIndicatorView.isHidden = false
        self.loadingImage.isHidden = true
        self.loadingImageLabel.isHidden = true
        self.completeLabel.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadingLabel.isHidden = true
            self?.activityIndicatorView.isHidden = true
            self?.loadingImage.isHidden = true
            self?.loadingImageLabel.isHidden = true
            self?.completeLabel.isHidden = false
        }
    }
    
    func showLoadingImage() {
        self.loadingLabel.isHidden = true
        self.activityIndicatorView.isHidden = true
        self.loadingImage.isHidden = false
        self.loadingImageLabel.isHidden = false
        self.completeLabel.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadingLabel.isHidden = true
            self?.activityIndicatorView.isHidden = true
            self?.loadingImage.isHidden = true
            self?.loadingImageLabel.isHidden = true
            self?.completeLabel.isHidden = false
        }
    }
    
    func setLabel(
        loadingText: String? = nil,
        loadingImageText: String? = nil,
        completeText: String? = nil
    ) {
        self.loadingLabel.text = loadingText
        self.loadingImageLabel.text = loadingImageText
        self.completeLabel.text = completeText
    }
}
