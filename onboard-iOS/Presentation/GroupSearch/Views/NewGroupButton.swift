//
//  NewGroupButton.swift
//  onboard-iOS
//
//  Created by main on 2023/10/20.
//

import UIKit
import SnapKit

final class NewGroupButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1)
        self.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        self.layer.cornerRadius = 16
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        self.setAttributedTitle(
            NSAttributedString(
                string: title ?? "",
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            ),
            for: state
        )
    }
}
