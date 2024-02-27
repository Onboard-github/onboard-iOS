//
//  SettingSeparatorCell.swift
//  onboard-iOS
//
//  Created by m1pro on 2/26/24.
//

import UIKit

class SettingSeparatorCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
