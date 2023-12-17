//
//  GameCell.swift
//  onboard-iOS
//
//  Created by main on 12/10/23.
//

import UIKit

struct GameCellInfo {
    enum DiceImg {
        case empty
        case dice
    }
    var rankNum: Int = 0
    var dice: DiceImg = .empty
    var isMe: Bool = false
    var userName: String = ""
    var playCount: Int = 0
    var isRedDot: Bool = false
    var score: Int = 0
}

class GameCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var meBadgeWidth: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var redDot: RoundedView!
    @IBOutlet weak var rightUpLabel: UILabel!
    @IBOutlet weak var rightBottomLabel: UILabel!
    
    var info: GameCellInfo = GameCellInfo() {
        didSet {
            reloadCell()
        }
    }
    
    func reloadCell() {
        leftLabel.text = "\(info.rankNum)"
        if info.dice == .dice {
            diceImageView.image = UIImage(named: "img_dice")
        } else {
            diceImageView.image = UIImage(named: "empty_dice")
        }
        if info.isMe {
            meBadgeWidth.constant = 14
        } else {
            meBadgeWidth.constant = 0
        }
        titleLabel.text = info.userName
        subTitleLabel.text = "\(info.playCount)회 플레이"
        redDot.isHidden = !info.isRedDot
        rightUpLabel.text = "\(info.score)"
        rightBottomLabel.text = "승점"
    }

//
//    override func prepareForReuse() {
//        resetView()
//    }
//    
//    func resetView() {
//        meBadgeWidth.constant = 14 //me 14 else 0
//        redDot.isHidden = true
//    }
    
    
}
