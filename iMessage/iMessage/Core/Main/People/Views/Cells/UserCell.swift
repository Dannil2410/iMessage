//
//  UserCell.swift
//  iMessage
//
//  Created by Даниил Кизельштейн on 03.12.2023.
//

import UIKit
import SnapKit

final class UserCell: UICollectionViewCell, SelfConfiguringCell {
    static var identifier: String = "UserCell"
    
    private lazy var avatarImageView: UIImageView = UIImageView(image: .avatar, contentMode: .scaleToFill)
    private lazy var userNameLabel: UILabel = UILabel(text: "User name", font: .laoSangamMN18())
    private lazy var containerView: UIView = UIView()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 4
    }
    
    func set<U>(using value: U) where U : Hashable {
        guard let user = value as? MUser else { return }
        self.avatarImageView.image = UIImage(named: user.avatarStringURL)
        self.userNameLabel.text = user.username
    }
    
    private func configureCell() {
        layer.shadowColor = UIColor.customColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func configureSubviews() {
        addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(userNameLabel)
        containerView.backgroundColor = .customColor.white
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(avatarImageView.snp.width)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(5)
            $0.top.equalTo(avatarImageView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}
