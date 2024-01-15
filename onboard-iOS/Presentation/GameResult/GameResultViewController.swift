//
//  GameResultViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/13/24.
//

import UIKit

final class GameResultViewController: UIViewController {
    
    // MARK: - Metric
    
    private enum Metric {
        static let progressBarHeight: CGFloat = 2
        static let labelTopSpacing: CGFloat = 15
        static let labelLeftMargin: CGFloat = 20
        static let collectionViewTopSpacing: CGFloat = 20
    }
    
    // MARK: - UI
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.tintColor = Colors.Orange_5
        bar.trackTintColor = Colors.Orange_1
        bar.progress = 1.0 / 3.0
        return bar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.game_result_title_info
        label.textColor = Colors.Gray_10
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private lazy var gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = Colors.White
        
        view.delegate = self
        view.dataSource = self
        view.register(GameResultCollectionViewCell.self,
                      forCellWithReuseIdentifier: "GameResultCollectionViewCell")
        return view
    }()
    
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
        self.view.backgroundColor = Colors.White
        
        self.makeConstraints()
        self.setNavigationBar()
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.progressBar)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.gameCollectionView)
        
        self.progressBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.progressBarHeight)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.labelLeftMargin)
        }
        
        self.gameCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.collectionViewTopSpacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        let image = IconImage.back.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        if let navigationBar = navigationController?.navigationBar {
            let textAttribute: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: Font.Typography.title2 as Any,
                NSAttributedString.Key.foregroundColor: Colors.Gray_14
            ]
            navigationBar.titleTextAttributes = textAttribute
        }
        
        navigationController?.navigationBar.barTintColor = Colors.White
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image, style: .done,
            target: self, action: #selector(showPrevious))
        navigationItem.title = TextLabels.owner_title
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension GameResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return 1
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameResultCollectionViewCell",
                                                          for: indexPath) as! GameResultCollectionViewCell
            return cell
        }
}
