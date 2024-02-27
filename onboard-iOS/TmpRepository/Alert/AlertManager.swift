//
//  AlertManager.swift
//  onboard-iOS
//
//  Created by main on 11/24/23.
//

import UIKit

class AlertManager {
    static func show(title: String? = nil, message: String, okHandler: (() -> Void)? = nil, addCancel: Bool = false) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                okHandler?()
            }
            
            alertController.addAction(okAction)
            
            if addCancel {
                let cancelAction = UIAlertAction(title: "취소", style: .cancel)
                alertController.addAction(cancelAction)
            }
            
            if let topViewController = getTopViewController() {
                topViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    static private func getTopViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .filter({ $0.activationState == .foregroundActive })
        .compactMap({ $0 as? UIWindowScene })
        .first?.windows
        .filter({ $0.isKeyWindow }).first?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return getTopViewController(base: nav.visibleViewController)
            } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            } else if let presented = base?.presentedViewController {
                return getTopViewController(base: presented)
            }
            return base
        }
}
