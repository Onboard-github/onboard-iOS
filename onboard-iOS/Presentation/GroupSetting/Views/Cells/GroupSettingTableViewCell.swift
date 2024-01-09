//
//  GroupSettingTableViewCell.swift
//  onboard-iOS
//
//  Created by 혜리 on 1/9/24.
//

import UIKit

final class GroupSettingTableViewCell: UITableViewCell {
    
    // MARK: - Metric
    
    private enum Metric {
        static let LeftMargin: CGFloat = 30
        static let separatorMargin: CGFloat = 14
        static let separatorHeight: CGFloat = 1
    }
    
    // MARK: - UI
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_14
        label.font = Font.Typography.body2_R
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray_5
        return view
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        self.selectionStyle = .none
        
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.addSubview(self.label)
        self.addSubview(self.separatorView)
        
        self.label.snp.makeConstraints {
            $0.leading.equalTo(Metric.LeftMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.separatorMargin)
            $0.height.equalTo(Metric.separatorHeight)
        }
    }
    
    func setOption(_ option: SettingOptions) {
        self.label.text = option.settings
        self.accessoryType = (option == .delete) ? .none : .disclosureIndicator
    }
}
