//
//  User.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation

struct User: Codable {
    static let collectionName = CollectionName.User
    
    var id: String?
    var apnsToken: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    var created: Double
    var createdBy: String
    var lastUpdated: Double
    var lastUpdatedBy: String
    var archived: Bool
    var archivedAt: Double?
}
