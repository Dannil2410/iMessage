//
//  ActiveChatCell.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import UIKit
import SnapKit

final class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
    static var identifier: String = "ActiveChatCell"
    
    private lazy var avatarImageView: UIImageView = UIImageView(image: .avatar, contentMode: .scaleAspectFill)
    private lazy var userNameLabel: UILabel = UILabel(text: "User name", font: .laoSangamMN20())
    private lazy var lastMessageLabel: UILabel = UILabel(text: "Last message", font: .laoSangamMN18())
    private lazy var gradientView = GradientView(
        startColor: .customColor.gradientStart,
        endColor: .customColor.gradientEnd,
        from: .topTrailing,
        to: .bottomLeading
    )
    
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
        self.userNameLabel.text = chat.userName
        self.lastMessageLabel.text = chat.lastMessage
    }
    
    private func configureCell() {
        backgroundColor = .customColor.white
        clipsToBounds = true
        layer.cornerRadius = 4
    }
    
    private func configureSubviews() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        addSubview(lastMessageLabel)
        addSubview(gradientView)
        
        avatarImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(78)
            $0.height.equalTo(78)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(avatarImageView).offset(-13)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(gradientView.snp.leading).offset(-16)
        }
        
        lastMessageLabel.snp.makeConstraints {
            $0.centerY.equalTo(avatarImageView).offset(13)
            $0.directionalHorizontalEdges.equalTo(userNameLabel)
        }
        
        gradientView.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(8)
        }
    }
}
