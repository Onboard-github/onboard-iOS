//
//  TextView.swift
//  onboard-iOS
//
//  Created by 혜리 on 11/22/23.
//

import UIKit

class TextView: UITextView {
    
    var placeholder: String? {
        didSet {
            self.updatePlaceholder()
        }
    }
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.Gray_7
        label.font = Font.Typography.body3_R
        label.numberOfLines = 0
        return label
    }()
    
    override var text: String! {
        didSet {
            self.updatePlaceholder()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.configure()
        self.makeConstraints()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.makeConstraints()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configure() {
        self.setColors()
        self.setupDefaults()
        self.setupBorder()
    }
    
    private func setColors() {
        self.backgroundColor = Colors.Gray_2
        self.tintColor = Colors.Orange_8
    }
    
    private func setupDefaults() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    private func setupBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Colors.Gray_5.cgColor
    }
    
    private func makeConstraints() {
        self.addSubview(placeholderLabel)
        
        self.placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.isHidden = !text.isEmpty || placeholder == nil
    }
    
    @objc
    private func textDidChange() {
        updatePlaceholder()
        delegate?.textViewDidChange?(self)
    }
}
