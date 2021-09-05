//
//  ChatMessage.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation

struct ChatMessage: Codable {
    static let collectionName = CollectionName.User
    
    var id: String?
    var authorId: String
    var messageText: String?
    var messageImageUrl: String?
    var created: Double
    var createdBy: String
    var lastUpdated: Double
    var lastUpdatedBy: String
    var archived: Bool
    var archivedAt: Double?
}
