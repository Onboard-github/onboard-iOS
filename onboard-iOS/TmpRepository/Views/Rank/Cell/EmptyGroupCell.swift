//
//  EmptyGroupCell.swift
//  onboard-iOS
//
//  Created by m1pro on 1/29/24.
//

import Foundation
import UIKit

struct EmptyGroupCellInfo {
}

class EmptyGroupCell: UITableViewCell {
    
    var info: EmptyGroupCellInfo = EmptyGroupCellInfo() {
        didSet {
            reloadCell()
        }
    }
    
    func reloadCell() {
    }
    
    @IBAction func groupJoinHandler(_ sender: Any) {
        if let viewController = self.findViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let useCase = GroupSearchUseCaseImpl(groupRepository: GroupRepositoryImpl())
            let groupListJoinVC = GroupSearchViewController(reactor: GroupSearchReactor(useCase: useCase))
            LoginSessionManager.setState(state: .needJoinGroup)
            let navVC = UINavigationController(rootViewController: groupListJoinVC)
            navVC.modalPresentationStyle = .fullScreen
            viewController.present(navVC, animated: true)
            LoginSessionManager.setState(state: .login)
        }
    }
}

extension UIResponder {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
