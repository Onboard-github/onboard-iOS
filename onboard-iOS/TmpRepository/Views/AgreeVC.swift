//
//  AgreeVC.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit
import PanModal

protocol AgreeDelegate {
    func agreeComplete()
}

class AgreeVC: UIViewController {
    var delegate: AgreeDelegate?
    
    override func viewDidLoad() {
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        delegate?.agreeComplete()
    }
}

extension AgreeVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
}
