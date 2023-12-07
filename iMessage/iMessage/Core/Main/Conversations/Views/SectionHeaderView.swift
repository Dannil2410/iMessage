//
//  SectionHeaderView.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import UIKit
import SnapKit

final class SectionHeaderView: UICollectionReusableView {
    static let identifier: String = "HeaderSectionView"
    
    private lazy var headerNameLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(headerName: String, font: UIFont?, textColor: UIColor) {
        self.headerNameLabel.text = headerName
        self.headerNameLabel.font = font
        self.headerNameLabel.textColor = textColor
    }
    
    private func configureSubviews() {
        addSubview(headerNameLabel)
        
        headerNameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
