//
//  TermCell.swift
//  onboard-iOS
//
//  Created by main on 12/28/23.
//

import UIKit

class TermCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var term: Term? {
        didSet {
            titleLabel.text = term?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func subtitleTapAction(_ sender: Any) {
        print("subtitle tapped")
    }
}
