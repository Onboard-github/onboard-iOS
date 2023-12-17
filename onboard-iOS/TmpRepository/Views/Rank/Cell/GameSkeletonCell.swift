//
//  GameSkeletonCell.swift
//  onboard-iOS
//
//  Created by main on 12/10/23.
//

import SkeletonView
import UIKit

class GameSkeletonCell: UITableViewCell {
    
    @IBOutlet weak var view0: RoundedView!
    @IBOutlet weak var view1: RoundedView!
    @IBOutlet weak var view2: RoundedView!
    @IBOutlet weak var view3: RoundedView!
    @IBOutlet weak var view4: RoundedView!
    @IBOutlet weak var view5: RoundedView!
    
    func showAnimation() {
        view2.isSkeletonable = true
        view3.isSkeletonable = true
        view2.showAnimatedGradientSkeleton()
        view3.showAnimatedGradientSkeleton()
    }
}
