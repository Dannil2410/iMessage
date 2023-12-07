//
//  OneLineTextField.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 26.11.2023.
//

import UIKit
import SnapKit

final class OneLineTextField: UITextField {
    init(font: UIFont? = .avenir20(), isSecureTextEntry: Bool = false) {
        super.init(frame: .zero)
        
        self.font = font
        self.borderStyle = .none
        self.isSecureTextEntry = isSecureTextEntry
        
        configureBottomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBottomView() {
        let bottomView = UIView()
        bottomView.backgroundColor = .customColor.gray
        
        self.addSubview(bottomView)
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
