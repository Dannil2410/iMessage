//
//  UIColor+Extensions.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 19.11.2023.
//

import UIKit

extension UIColor {
    static let customColor = CustomColor()
}

struct CustomColor {
    let white = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let red = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    let purple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    let gray = #colorLiteral(red: 0.9214347005, green: 0.9214347005, blue: 0.9214347005, alpha: 1)
    let background = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
    let gradientStart = #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1)
    let gradientEnd = #colorLiteral(red: 0.5460671782, green: 0.7545514107, blue: 0.9380497336, alpha: 1)
    let secondaryText = #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1)
}
