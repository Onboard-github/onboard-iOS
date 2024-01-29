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
}
