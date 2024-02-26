//
//  AlertManager.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit

class AlertManager {
    static func show(title: String? = nil, message: String, okHandler: (()->Void)? = nil, addCancel: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            okHandler?()
        }
        
        alertController.addAction(okAction)
        
        if addCancel {
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            }
            alertController.addAction(cancelAction)
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let currentViewController = windowScene.windows.last?.rootViewController {
            currentViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
