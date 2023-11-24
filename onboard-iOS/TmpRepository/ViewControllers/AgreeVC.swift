//
//  AgreeVC.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit
import PanModal

class AgreeVC: UIViewController {
    override func viewDidLoad() {
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
}

extension AgreeVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
}
