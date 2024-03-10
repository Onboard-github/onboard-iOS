//
//  GroupSearchBar.swift
//  onboard-iOS
//
//  Created by main on 2023/10/20.
//

import UIKit
import SnapKit

final class GroupSearchBar: UITextField {
    var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1)
        return line
    }()
    
    var rightImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "search_bar_logo")
        return imageView
    }()
    
    override var placeholder: String? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor(red: 193/255.0, green: 193/255.0, blue: 193/255.0, alpha: 1),
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
                ])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 14)
        
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(1)
        }
        
        addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.trailing.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
