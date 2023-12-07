//
//  MUser.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import Foundation

struct MUser: Hashable, Decodable {
    let id: Int
    let username: String
    let avatarStringURL: String
}
