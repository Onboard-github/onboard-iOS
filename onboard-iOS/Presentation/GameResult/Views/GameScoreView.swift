//
//  GameScoreView.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/25/24.
//

import UIKit

import RxSwift
import RxCocoa

final class GameScoreView: UIView {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    var didTapButtonAction: (() -> Void)?
    
    // MARK: - Metric
    
    private enum Metric {
        static let iconSize: CGFloat = 16
        static let progressBarHeight: CGFloat = 2
        static let labelTopSpacing: CGFloat = 15
        static let leftRightMargin: CGFloat = 20
        static let labelLeading: CGFloat = 5
        static let iconLeading: CGFloat = 10
        static let tableViewTopSpacing: CGFloat = 30
        static let tableViewSpacing: CGFloat = 10
        static let buttonBottomMargin: CGFloat = 10
        static let buttonHeight: CGFloat = 48
    }
    
    // MARK: - UI
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.tintColor = Colors.Orange_5
        bar.trackTintColor = Colors.Orange_1
        bar.progress = 19.0 / 20.0
        return bar
    }()
    
    private let calendarIcon: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.calendarLine1.image
        imageView.image = image
        return imageView
    }()
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TextLabels.game_record_calendar
        
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        label.text = formattedDate
        
        GameDataSingleton.shared.calendarText.accept(label.text ?? "")
        
        return label
    }()
    
    private let timeIcon: UIImageView = {
        let imageView = UIImageView()
        let image = IconImage.timeLine1.image
        imageView.image = image
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_9
        label.font = Font.Typography.body4_R
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = TextLabels.game_record_time
        
        let currentTime = Date()
        let formattedTime = timeFormatter.string(from: currentTime)
        label.text = formattedTime
        
        GameDataSingleton.shared.timeText.accept(label.text ?? "")
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = GameDataSingleton.shared.gameData.map { "\($0.name) \(TextLabels.game_record_title_info)" }
        label.textColor = Colors.Gray_13
        label.font = Font.Typography.body2_M
        return label
    }()
    
    private lazy var playerTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 70
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.delegate = self
        view.dataSource = self
        view.register(GameScoreTableViewCell.self,
                      forCellReuseIdentifier: "GameScoreTableViewCell")
        return view
    }()
    
    private let confirmButton: BaseButton = {
        let button = BaseButton(status: .disabled, style: .rounded)
        button.setTitle(TextLabels.game_record_confirm, for: .normal)
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
        self.setupDismissKeyboardGesture() // 탭 제스처를 설정하는 함수 호출
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true) // 뷰의 편집 모드를 종료하여 키보드를 내림
    }
    
    private func addConfigure() {
        self.confirmButton.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapButtonAction?()
        }), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        self.addSubview(self.progressBar)
        self.addSubview(self.calendarIcon)
        self.addSubview(self.calendarLabel)
        self.addSubview(self.timeIcon)
        self.addSubview(self.timeLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.playerTableView)
        self.addSubview(self.confirmButton)
        
        self.progressBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.progressBarHeight)
        }
        
        self.calendarIcon.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.calendarLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalTo(calendarIcon.snp.trailing).offset(Metric.labelLeading)
        }
        
        self.timeIcon.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalTo(calendarLabel.snp.trailing).offset(Metric.iconLeading)
        }
        
        self.timeLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalTo(timeIcon.snp.trailing).offset(Metric.labelLeading)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(calendarIcon.snp.bottom).offset(Metric.labelTopSpacing)
            $0.leading.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.playerTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.tableViewTopSpacing)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-Metric.tableViewSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-Metric.buttonBottomMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension GameScoreView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return GameDataSingleton.shared.gamePlayerData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameScoreTableViewCell",
                                                 for: indexPath) as! GameScoreTableViewCell
        
        let selectedPlayer = GameDataSingleton.shared.gamePlayerData[indexPath.item]
        let titleImage = selectedPlayer.role == "GUEST" ? IconImage.emptyDice.image : IconImage.dice.image
        cell.configure(rank: "\(indexPath.row + 1)\(TextLabels.game_record_rank)",
                       image: titleImage,
                       title: selectedPlayer.nickname)
        
        cell.scoreTextField.tag = indexPath.row
        cell.scoreTextField.text = selectedPlayer.score
        
        cell.scoreTextField.rx.text.asObservable()
            .subscribe(onNext: { scoreText in
                let color = scoreText?.isEmpty == true ? Colors.Gray_6 : Colors.Gray_11
                cell.updateUnderLineColor(colors: color)
            })
            .disposed(by: disposeBag)
        
        cell.scoreTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                self?.textFieldDidEndEditing(cell.scoreTextField, at: indexPath)
            })
            .disposed(by: disposeBag)
        
        cell.scoreTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: {
                cell.updateUnderLineColor(colors: Colors.Gray_11)
            })
            .disposed(by: disposeBag)
        
        self.confirmButton.status = cell.scoreTextField.text!.isEmpty ? .disabled : .default
        
        return cell
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField, at indexPath: IndexPath) {
        let index = textField.tag
        guard let newScoreText = textField.text,
                let newScore = Int(newScoreText.replacingOccurrences(of: ",", with: "")) else {
            print("유효하지 않은 값")
            return
        }
        
        GameDataSingleton.shared.gamePlayerData[index].score = String(newScore)
        
        GameDataSingleton.shared.gamePlayerData.sort { Int($0.score ?? "0") ?? 0 > Int($1.score ?? "0") ?? 0 }
        
        self.playerTableView.reloadRows(at: [indexPath], with: .fade)
        self.playerTableView.reloadData()
    }
}
