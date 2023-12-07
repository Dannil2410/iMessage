//
//  SelfConfiguringCell.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import Foundation

protocol SelfConfiguringCell {
    static var identifier: String { get }
    func set<U: Hashable>(using value: U)
}
