//
//  FormView.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 28.11.2023.
//

import UIKit
import SnapKit

final class FormView: UIStackView {

    init(label: UILabel, button: UIButton, spacing: CGFloat = 5) {
        super.init(frame: .zero)
        
        configure(spacing: spacing)
        
        addArrangedSubview(label)
        addArrangedSubview(button)
        
        button.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    init(label: UILabel, textField: UITextField, spacing: CGFloat = 5) {
        super.init(frame: .zero)
        
        configure(spacing: spacing)
        
        addArrangedSubview(label)
        addArrangedSubview(textField)
        
        textField.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    init(label: UILabel, segmentedControl: UISegmentedControl, spacing: CGFloat = 20) {
        super.init(frame: .zero)
        
        configure(spacing: spacing)
        
        addArrangedSubview(label)
        addArrangedSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(spacing: CGFloat) {
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = .leading
        self.distribution = .fill
    }
}
