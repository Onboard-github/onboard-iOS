//
//  ProfileCell.swift
//  onboard-iOS
//
//  Created by m1pro on 2/26/24.
//

import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet weak var leftTopLabel: UILabel!
    @IBOutlet weak var rightTopLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
