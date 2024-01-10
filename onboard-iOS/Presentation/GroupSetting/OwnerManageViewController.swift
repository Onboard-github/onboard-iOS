//
//  OwnerManageViewController.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/10/24.
//

import UIKit

final class OwnerManageViewController: UIViewController {
    
    // MARK: - Metric
    
    private enum Metric {
        static let iconSize: CGFloat = 16
    }
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLabels.owner_title_info
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
        
        view.register(OwnerManageTableViewCell.self,
                      forCellReuseIdentifier: "OwnerManageTableViewCell")
        return view
    }()
    
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
        (IconImage.dice.image!, "관리자변경하지마"),
        (IconImage.dice.image!, "먀옹"),
        (IconImage.dice.image!, "히히"),
        (IconImage.emptyDice.image!, "임시임"),
        (IconImage.dice.image!, "메메메"),
        (IconImage.emptyDice.image!, "몜몜"),
        (IconImage.dice.image!, "맴맴")
    ]
}
