//
//  Array.swift
//  onboard-iOS
//
//  Created by 혜리 on 3/15/24.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
