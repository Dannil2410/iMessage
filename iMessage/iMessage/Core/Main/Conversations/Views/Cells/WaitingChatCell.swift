//
//  WaitingChatCell.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import UIKit
import SnapKit

final class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    static var identifier: String = "WaitingChatCell"
    
    private lazy var avatarImageView: UIImageView = UIImageView(image: .avatar, contentMode: .scaleAspectFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
    }
    
    func set<U>(using value: U) where U : Hashable {
        guard let chat = value as? MChat else { return }
        self.avatarImageView.image = UIImage(named: chat.userImageString ?? "")
    }
    
    private func configureCell() {
        
        clipsToBounds = true
        layer.cornerRadius = 4
    }
    
    private func configureSubviews() {
        addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
