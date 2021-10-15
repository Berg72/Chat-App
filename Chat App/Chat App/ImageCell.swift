//
//  ImageCell.swift
//  Chat App
//
//  Created by Mark bergeson on 10/11/21.
//

import UIKit

class ImageCell: UITableViewCell {
        
        private let containerView = UIView()
        private let messageImageView = UIImageView()
        private let timeAgoLabel = UILabel()
        
        override func prepareForReuse() {
            super.prepareForReuse()
            messageImageView.image = nil
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(message: ChatMessage) {
            let date = Date(timeIntervalSince1970: message.created)
            timeAgoLabel.text = date.timeAgoDisplay()
            
            if message.authorId != Database.shared.currentUser?.id {
                containerView.backgroundColor = .gray1
                
            } else {
                containerView.backgroundColor = .blue1
                
            }
            
            if let urlString = message.messageImageUrl, let url = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let data = try? Data(contentsOf: url) else { return }
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.messageImageView.image = image
                    }
                }
            }
            
        }
    }


private extension ImageCell {
    
    func setupView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .blue1
        containerView.layer.cornerRadius = 20.0
        contentView.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80.0).isActive = true
        
        containerView.layer.applySketchShadow(color: UIColor(white: 151.0 / 255.0, alpha: 0.50), alpha: 1.0, x: 0.0, y: 2.0, blur: 4.0, spread: 0.0)
        
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.contentMode = .scaleAspectFill
        messageImageView.layer.cornerRadius = 20.0
        messageImageView.clipsToBounds = true
        messageImageView.layer.masksToBounds = true
        containerView.addSubview(messageImageView)
        
        messageImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15.0).isActive = true
        messageImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15.0).isActive = true
        messageImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15.0).isActive = true
        messageImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.0).isActive = true
        
        let size = UIScreen.main.bounds.width - 125.0
        messageImageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: size).isActive = true
        
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
