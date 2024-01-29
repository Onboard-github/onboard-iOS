//
//  TermCell.swift
//  onboard-iOS
//
//  Created by main on 12/28/23.
//

import UIKit
import SafariServices

class TermCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    var checked = false {
        didSet {
            if checked {
                checkImg.image = UIImage(named: "check_orange")
            } else {
                checkImg.image = UIImage(named: "check_gray")
            }
        }
    }
    
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
        if let urlString = term?.url, let url = URL(string: urlString) {
            let safariViewController = SFSafariViewController(url: url)
            
            // Present the SafariViewController
            if let parentViewController = findViewController() {
                parentViewController.present(safariViewController, animated: true, completion: nil)
            }
        }
    }
}
