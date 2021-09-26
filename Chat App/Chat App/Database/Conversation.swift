//
//  Conversation.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation

struct Conversation: CPObject {
    static let collectionName = CollectionName.Conversation
    
    var id: String?
    var participants: [User]
    var participantsId: [String]
    var lastMessageText: String?
    var created: Double
    var createdBy: String
    var lastUpdated: Double
    var lastUpdatedBy: String
    var archived: Bool
    var archivedAt: Double?
}

extension Conversation {
    
    static func getConversations(userId: String, onComplete: @escaping (_ conversations: [Conversation]?, _ error: Error?) -> ()) {
        Database.shared.db.collection(collectionName.rawValue).whereField("participantsId", arrayContains: userId).getDocuments { (snapshot, error) in
            if let error = error {
                onComplete(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                onComplete(nil, nil)
                return
            }
            
            var objects = [Conversation]()
            for document in documents {
                do {
                    let obj = try document.decode(as: Conversation.self)
                    objects.append(obj)
                } catch {
                    print(error)
                    onComplete(nil, error)
                }
            }
            onComplete(objects, nil)
        }
    }
}
