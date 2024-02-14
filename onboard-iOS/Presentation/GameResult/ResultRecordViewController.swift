//
//  ResultRecordViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/6/24.
//

import UIKit

final class ResultRecordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let resultRecordView = ResultRecordView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        self.view = resultRecordView
    }
    
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
        self.setupGestureRecognizer()
    }
    
    private func addConfigure() {
        
        resultRecordView.didTapCloseButtonAction = { [weak self] in
            self?.dismiss(animated: false)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func backgroundTapped() {
        self.dismiss(animated: false)
    }
}
