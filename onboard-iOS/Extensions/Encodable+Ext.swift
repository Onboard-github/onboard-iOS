//
//  Encodable+Ext.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/09/30.
//

import Foundation

extension Encodable {

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
