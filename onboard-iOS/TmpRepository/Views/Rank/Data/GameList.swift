//
//  GameList.swift
//  onboard-iOS
//
//  Created by main on 11/26/23.
//

import Foundation

struct Game: Codable {
    var id: Int
    var name: String
    var minMember: Int
    var maxMember: Int
    var img: String //url
    var matchCount: Int
}

struct GamgeList: Codable {
    var list: [Game]
}
