//
//  AddPhotoView.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 28.11.2023.
//

import UIKit
import SnapKit

final class AddPhotoView: UIView {
    
    private lazy var circleImageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
    
    lazy var addPhotoButton: UIButton = UIButton(image: .plus, tintColor: .customColor.black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.borderColor = UIColor.customColor.black.cgColor
        circleImageView.layer.borderWidth = 1
        circleImageView.layer.cornerRadius = circleImageView.bounds.height / 2
        
    }
    
    private func configureSubviews() {
        self.addSubview(circleImageView)
        self.addSubview(addPhotoButton)
        
        circleImageView.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(circleImageView.snp.height)
        }
        
        addPhotoButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(circleImageView.snp.trailing).offset(16)
            $0.height.equalTo(30)
            $0.width.equalTo(addPhotoButton.snp.height)
        }
        addPhotoButton.backgroundColor = .clear
    }
    
}
