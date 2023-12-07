//
//  UIImageView+Extensions.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 19.11.2023.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage, contentMode: UIView.ContentMode = .scaleAspectFit, renderingMode: UIImage.RenderingMode = .alwaysOriginal, _ tintColor: UIColor = .customColor.purple) {
        self.init()
        if renderingMode == .alwaysOriginal {
            self.image = image
        } else {
            self.image = image.withTintColor(tintColor, renderingMode: renderingMode)
        }
        self.contentMode = contentMode
    }
}
