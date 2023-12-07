//
//  UILabel+Extensions.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 19.11.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        self.text = text
        self.font = font
    }
}
