//
//  MessageCell.swift
//  Chat App
//
//  Created by Mark bergeson on 10/3/21.
//

import UIKit

class MessageCell: UITableViewCell {
    
    private let containerView = UIView()
    private let messageTextLabel = UILabel()
    private let timeAgoLabel = UILabel()
    
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
    
    func configure(message: ChatMessage) {
        messageTextLabel.text = message.messageText
        let date = Date(timeIntervalSince1970: message.created)
        timeAgoLabel.text = date.timeAgoDisplay()
        
        if message.authorId != Database.shared.currentUser?.id {
            containerView.backgroundColor = .white
            messageTextLabel.textColor = .black
        } else {
            containerView.backgroundColor = .blue1
            messageTextLabel.textColor = .white
        }
    }
}

private extension MessageCell {
    
    func setupView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .blue1
        containerView.layer.cornerRadius = 20.0
        contentView.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80.0).isActive = true
        
        containerView.layer.applySketchShadow(color: UIColor(white: 151.0 / 255.0, alpha: 0.50), alpha: 1.0, x: 0.0, y: 2.0, blur: 4.0, spread: 0.0)
        
        messageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        messageTextLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        messageTextLabel.textColor = .white
        messageTextLabel.text = "Was that the one with the actor that you and I thought was way too strong to play the part"
        messageTextLabel.numberOfLines = 0
        messageTextLabel.lineBreakMode = .byWordWrapping
        containerView.addSubview(messageTextLabel)
        
        messageTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15.0).isActive = true
        messageTextLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15.0).isActive = true
        messageTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15.0).isActive = true
        messageTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
        
        timeAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        timeAgoLabel.textColor = .black.withAlphaComponent(0.50)
        timeAgoLabel.text = "4:30pm"
        contentView.addSubview(timeAgoLabel)
        
        timeAgoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        timeAgoLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10.0).isActive = true
        timeAgoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    }
}
