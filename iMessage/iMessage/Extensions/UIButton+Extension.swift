//
//  UIButton+Extension.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 19.11.2023.
//

import UIKit
import SnapKit

extension UIButton {
    
    convenience init(
        _ configuration: UIButton.Configuration = .plain(),
        title: String, 
        titleColor: UIColor = .customColor.black,
        font: UIFont? = .avenir20(),
        backgroundColor: UIColor = .customColor.white,
        isShadow: Bool = true,
        cornerRadius: CGFloat = 10
    ) {
        self.init(type: .system)
        
        self.configuration = configuration
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
    
    convenience init(
        image: UIImage,
        tintColor: UIColor = .customColor.black,
        backgroundColor: UIColor = .customColor.white,
        isShadow: Bool = true
    ) {
        self.init(type: .system)
        
        self.setImage(image, for: .normal)
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
    
    func customizeGoogleButton() {
        let googleLogo = UIImageView(image: #imageLiteral(resourceName: "googleLogo"))
        
        self.addSubview(googleLogo)
        
        googleLogo.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
    }
}
