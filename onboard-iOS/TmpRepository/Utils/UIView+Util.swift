//
//  UIView+Util.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit

@IBDesignable
class RotatableView: UIImageView {

    @IBInspectable var rotationDegrees: CGFloat = 0 {
        didSet {
//            print("Setting angle to \(rotationDegrees)")
            let angle = rotationDegrees / 180.0 * CGFloat.pi
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }

    // 코드에서 초기화할 때 호출되는 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // 스토리보드 또는 인터페이스 빌더에서 초기화할 때 호출되는 메서드
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // 초기화 코드를 모아둔 메서드
    private func setupView() {
        // 추가적인 초기화 코드가 필요하다면 여기에 작성
    }

    // 스토리보드에서 디자인 타임에 모양을 미리 확인하기 위한 코드
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}

@IBDesignable
class BorderedButton: UIButton {

    @IBInspectable var enableColor: UIColor = UIColor.lightGray {
        didSet {
            updateButtonAppearanceForState()
        }
    }
    @IBInspectable var disabledColor: UIColor = UIColor.lightGray {
        didSet {
            updateButtonAppearanceForState()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateButtonAppearanceForState()
        }
    }

    private func updateButtonAppearanceForState() {
        if isEnabled {
            backgroundColor = enableColor
        } else {
            backgroundColor = disabledColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.gray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    // 코드에서 초기화할 때 호출되는 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    // 스토리보드 또는 인터페이스 빌더에서 초기화할 때 호출되는 메서드
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    // 초기화 코드를 모아둔 메서드
    private func setupButton() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

    // 스토리보드에서 디자인 타임에 모양을 미리 확인하기 위한 코드
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
}

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.gray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    // 코드에서 초기화할 때 호출되는 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    // 스토리보드 또는 인터페이스 빌더에서 초기화할 때 호출되는 메서드
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    // 초기화 코드를 모아둔 메서드
    private func setupButton() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

    // 스토리보드에서 디자인 타임에 모양을 미리 확인하기 위한 코드
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
}

@IBDesignable
class CheckButton: UIButton {
    @IBInspectable var checked: Bool = false {
        didSet {
            updateImage()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        updateImage()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }

    @objc private func buttonTapped() {
        checked.toggle()
    }

    private func updateImage() {
        if checked {
            setImage(UIImage(named: "check_orange"), for: .normal)
        } else {
            setImage(UIImage(named: "check_gray"), for: .normal)
        }
    }
}
