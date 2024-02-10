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
        self.addSubview(self.backgroundView)
        self.addSubview(self.loadingLabel)
        self.addSubview(self.activityIndicatorView)
        
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
    }
    
    internal func setLoadingLabel(_ text: String) {
        self.loadingLabel.text = text
    }
}


final class ImageLoadingView: UIView {
    
    // MARK: - Metric
    
    enum Metric {
        static let labelBottomSpacing: CGFloat = 20
    }
    
    // MARK: - UI
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let loadingImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let loadingLabel: UILabel = {
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
        
        self.loadImage()
        self.makeConstraints()
    }
    
    private func loadImage() {
        if let gifURL = URL(string: GifURL.url) {
            downloadGif(url: gifURL)
        }
    }
    
    private func makeConstraints() {
        self.addSubview(self.backgroundView)
        self.addSubview(self.loadingImage)
        self.addSubview(self.loadingLabel)
        self.addSubview(self.completeLabel)
        
        self.backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.loadingImage.snp.makeConstraints {
            $0.bottom.equalTo(loadingLabel.snp.top).offset(Metric.labelBottomSpacing)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(224)
        }
        
        self.loadingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.completeLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func downloadGif(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print("Error downloading gif: \(error.localizedDescription)")
                return
            }
            
            if let data = data,
                let gifImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.loadingImage.image = gifImage
                }
            }
        }.resume()
    }
    
    func showStatus() {
        self.loadingImage.isHidden = false
        self.loadingLabel.isHidden = false
        self.completeLabel.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadingImage.isHidden = true
            self?.loadingLabel.isHidden = true
            self?.completeLabel.isHidden = false
        }
    }
    
    func setLabel(loading: String, complete: String) {
        self.loadingLabel.text = loading
        self.completeLabel.text = complete
    }
}
