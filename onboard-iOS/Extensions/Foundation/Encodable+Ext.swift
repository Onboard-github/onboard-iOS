//
//  Encodable+Ext.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/23.
//

import Foundation

extension Encodable {

    /// Encodable -> Dictionary([String: Any])로 변환
    func encode() throws -> [String: Any] {

        let data = try JSONEncoder().encode(self)

        guard let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any] else {
            throw NSError()
        }

        return dictionary
    }
}

