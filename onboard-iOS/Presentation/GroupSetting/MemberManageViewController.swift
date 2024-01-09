//
//  MemberManageViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class MemberManageViewController: UIViewController {
    
    // MARK: - Metric
    
    private enum Metric {
        static let iconSize: CGFloat = 16
        static let topMargin: CGFloat = 25
        static let leftRightMargin: CGFloat = 20
        static let textFieldTopSpacing: CGFloat = 10
        static let textFieldHeight: CGFloat = 40
        static let tableViewTopSpacing: CGFloat = 20
    }
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.member_title_info
        label.textColor = Colors.Gray_10
        label.font = Font.Typography.body3_R
        return label
    }()
    
    private let textField: TextField = {
        let textField = TextField()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Metric.iconSize + 20, height: Metric.iconSize))
        let image = UIImageView(image: IconImage.search_gray.image)
        image.contentMode = .center
        image.frame = CGRect(x: 0, y: 0, width: Metric.iconSize, height: Metric.iconSize)
        view.addSubview(image)
        textField.rightView = view
        textField.rightViewMode = .always
        
        textField.textColor = Colors.Gray_15
        textField.font = Font.Typography.body2_M
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 52
        view.backgroundColor = Colors.White
        view.separatorStyle = .none
        
        view.register(MemberManageTableViewCell.self,
                      forCellReuseIdentifier: "MemberManageTableViewCell")
        return view
    }()
    
    // 임시 데이터
    private let tmpData: [(UIImage, String)] = [
        (IconImage.dice.image!, "귤귤"),
        (IconImage.emptyDice.image!, "호연호연"),
        (IconImage.dice.image!, "승용용용용"),
        (IconImage.dice.image!, "메롱메롱"),
        (IconImage.dice.image!, "푸항항"),
        (IconImage.emptyDice.image!, "하하하하하"),
        (IconImage.emptyDice.image!, "호호홍"),
        (IconImage.emptyDice.image!, "막창"),
        (IconImage.dice.image!, "낙곱새맛있겠다"),
        (IconImage.dice.image!, "마라탕"),
        (IconImage.emptyDice.image!, "마라샹궈"),
        (IconImage.dice.image!, "멤버삭제하지마"),
        (IconImage.dice.image!, "먀옹"),
        (IconImage.dice.image!, "히히"),
        (IconImage.emptyDice.image!, "임시임"),
        (IconImage.dice.image!, "메메메"),
        (IconImage.emptyDice.image!, "몜몜"),
        (IconImage.dice.image!, "맴맴")
    ]
    
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
        
        self.textFieldPlaceHolder()
        self.makeConstraints()
        self.setNavigationBar()
    }
    
    private func textFieldPlaceHolder() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Font.Typography.body3_R as Any,
            .foregroundColor: Colors.Gray_7]
        textField.attributedPlaceholder = NSAttributedString(string: TextLabels.member_placeholder,
                                                             attributes: attributes)
    }
    
    private func makeConstraints() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.tableView)
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Metric.topMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
        }
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.textFieldTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.leftRightMargin)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Metric.tableViewTopSpacing)
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
        navigationItem.title = TextLabels.member_title
    }
    
    @objc
    private func showPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
}
