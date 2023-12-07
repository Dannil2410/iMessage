//
//  MChat.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import Foundation

struct MChat: Hashable, Decodable {
    var id: Int
    let userName: String
    let userImageString: String?
    let lastMessage: String
}
