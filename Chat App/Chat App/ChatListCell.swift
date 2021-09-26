//
//  ChatListCell.swift
//  Chat App
//
//  Created by Mark bergeson on 9/19/21.
//

import UIKit

class ChatListCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let timeAgoLabel = UILabel()
    private let lastMessageLabel = UILabel()
        
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(conversation: Conversation) {
        nameLabel.text = conversation.participants.first(where: { $0.id != Database.shared.currentUser?.id })?.name
        lastMessageLabel.text = conversation.lastMessageText
        let date = Date(timeIntervalSince1970: conversation.lastUpdated)
        timeAgoLabel.text = date.timeAgoDisplay()
    }
    
}

private extension ChatListCell {
    
    func setupView() {
        accessoryType = .disclosureIndicator
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.text = "Buster Posey"
        contentView.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100.0).isActive = true
        
        lastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        lastMessageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        lastMessageLabel.textColor = UIColor.black.withAlphaComponent(0.50)
        lastMessageLabel.text = "Last Message"
        contentView.addSubview(lastMessageLabel)
        
        lastMessageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4.0).isActive = true
        lastMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        lastMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0).isActive = true
        lastMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0).isActive = true
        
        timeAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        timeAgoLabel.textColor = UIColor.black.withAlphaComponent(0.50)
        timeAgoLabel.text = "2w ago"
        contentView.addSubview(timeAgoLabel)
        
        timeAgoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0).isActive = true
        timeAgoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0).isActive = true
    }
}


