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
