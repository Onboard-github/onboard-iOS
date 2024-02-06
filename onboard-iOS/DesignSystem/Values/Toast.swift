//
//  Toast.swift
//  onboard-iOS
//
//  Created by 혜리 on 2/6/24.
//

import UIKit

class Toast {
    
    func showToast(image: UIImage, message: String) {
        
        let toastView = UIView()
        
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            toastView.backgroundColor = Colors.Gray_15
            toastView.clipsToBounds = true
            toastView.layer.cornerRadius = 30
            
            window.addSubview(toastView)
            window.bringSubviewToFront(toastView)
            
            toastView.snp.makeConstraints{
                $0.width.equalTo(327)
                $0.height.equalTo(58)
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-48)
            }
            
            let img = UIImageView()
            toastView.addSubview(img)
            img.image = image
            img.snp.makeConstraints {
                $0.left.equalTo(30)
                $0.centerY.equalToSuperview()
            }
            
            let label = UILabel()
            toastView.addSubview(label)
            label.text = message
            label.textColor = Colors.Gray_1
            label.font = Font.Typography.body3_M
            label.snp.makeConstraints {
                $0.left.equalTo(70)
                $0.centerY.equalToSuperview()
            }
            
            UIView.animate(withDuration: 4.0, delay: 0.0, options: [.curveEaseOut], animations: {
                toastView.alpha = 1.0
            })
            
            UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseIn], animations: {
                toastView.alpha = 0.0
            }, completion: {(isCompleted) in
                toastView.removeFromSuperview()
            })
        }
    }
}
