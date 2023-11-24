//
//  AlertManager.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit

class AlertManager {
    static func show(title: String? = nil, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
//            print("확인 버튼이 눌렸습니다.")
        }
        
        alertController.addAction(okAction)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let currentViewController = windowScene.windows.first?.rootViewController {
            currentViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
