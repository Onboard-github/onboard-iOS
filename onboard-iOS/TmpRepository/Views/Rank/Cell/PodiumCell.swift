//
//  PodiumCell.swift
//  onboard-iOS
//
//  Created by main on 12/12/23.
//

import UIKit

class PodiumUserInfo {
    enum DiceImg {
        case empty
        case dice
    }
    var isEmptyUser: Bool = true
    var dice: DiceImg = .empty
    var isMe: Bool = false
    var userName: String = ""
    var score: Int = 0
    var playCount: Int = 0
    var isRedDot: Bool = false
}

class PodiumCell: UITableViewCell {
    @IBOutlet weak var firstDiceImg: UIImageView!
    @IBOutlet weak var secondDiceImg: UIImageView!
    @IBOutlet weak var thirdDiceImg: UIImageView!
    @IBOutlet weak var firstUserTitle: UILabel!
    @IBOutlet weak var secondUserTitle: UILabel!
    @IBOutlet weak var thirdUserTitle: UILabel!
    @IBOutlet weak var firstMeBadgeWidth: NSLayoutConstraint!
    @IBOutlet weak var secondMeBadgeWidth: NSLayoutConstraint!
    @IBOutlet weak var thirdMeBadgeWidth: NSLayoutConstraint!
    @IBOutlet weak var firstUserRedDot: RoundedView!
    @IBOutlet weak var secondUserRedDot: RoundedView!
    @IBOutlet weak var thirdUserRedDot: RoundedView!
    @IBOutlet weak var firstUserScore: UILabel!
    @IBOutlet weak var secondUserScore: UILabel!
    @IBOutlet weak var thirdUserScore: UILabel!
    @IBOutlet weak var firstUserGameCount: UILabel!
    @IBOutlet weak var secondUserGameCount: UILabel!
    @IBOutlet weak var thirdUserGameCount: UILabel!
    
    
    var firstUserInfo: PodiumUserInfo = PodiumUserInfo() {
        didSet {
            if firstUserInfo.isEmptyUser {
                firstDiceImg.image = UIImage(named: "empty_dice")
                firstUserTitle.text = "-"
                firstMeBadgeWidth.constant = 0
                firstUserRedDot.isHidden = true
                firstUserScore.text = ""
                firstUserGameCount.text = ""
                
            } else {
                if firstUserInfo.dice == .dice {
                    firstDiceImg.image = UIImage(named: "img_dice")
                } else {
                    firstDiceImg.image = UIImage(named: "empty_dice")
                }
                firstUserTitle.text = firstUserInfo.userName
                if firstUserInfo.isMe {
                    firstMeBadgeWidth.constant = 14
                } else {
                    firstMeBadgeWidth.constant = 0
                }
                firstUserScore.text = "\(firstUserInfo.score)"
                firstUserGameCount.text = "\(firstUserInfo.playCount)회"
            }
        }
    }
    var secondUserInfo: PodiumUserInfo = PodiumUserInfo() {
        didSet {
            if secondUserInfo.isEmptyUser {
                secondDiceImg.image = UIImage(named: "empty_dice")
                secondUserTitle.text = "-"
                secondMeBadgeWidth.constant = 0
                secondUserRedDot.isHidden = true
                secondUserScore.text = ""
                secondUserGameCount.text = ""
                
            } else {
                if secondUserInfo.dice == .dice {
                    secondDiceImg.image = UIImage(named: "img_dice")
                } else {
                    secondDiceImg.image = UIImage(named: "empty_dice")
                }
                secondUserTitle.text = secondUserInfo.userName
                if secondUserInfo.isMe {
                    secondMeBadgeWidth.constant = 14
                } else {
                    secondMeBadgeWidth.constant = 0
                }
                secondUserScore.text = "\(secondUserInfo.score)"
                secondUserGameCount.text = "\(secondUserInfo.playCount)회"
            }
        }
    }
    var thirdUserInfo: PodiumUserInfo = PodiumUserInfo() {
        didSet {
            if thirdUserInfo.isEmptyUser {
                thirdDiceImg.image = UIImage(named: "empty_dice")
                thirdUserTitle.text = "-"
                thirdMeBadgeWidth.constant = 0
                thirdUserRedDot.isHidden = true
                thirdUserScore.text = ""
                thirdUserGameCount.text = ""
                
            } else {
                if thirdUserInfo.dice == .dice {
                    thirdDiceImg.image = UIImage(named: "img_dice")
                } else {
                    thirdDiceImg.image = UIImage(named: "empty_dice")
                }
                thirdUserTitle.text = thirdUserInfo.userName
                if thirdUserInfo.isMe {
                    thirdMeBadgeWidth.constant = 14
                } else {
                    thirdMeBadgeWidth.constant = 0
                }
                thirdUserScore.text = "\(thirdUserInfo.score)"
                thirdUserGameCount.text = "\(thirdUserInfo.playCount)회"
            }
        }
    }
    
    
}
