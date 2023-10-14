//
//  GroupSearchCell.swift
//  onboard-iOS
//
//  Created by main on 2023/10/14.
//

import UIKit

final class GroupSearchCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemCyan
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

