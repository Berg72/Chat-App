//
//  ChatMessage.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation
import FirebaseFirestore

struct ChatMessage: CPObject {
    static let collectionName = CollectionName.ChatMessage
    
    var id: String?
    var conversationId: String
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

extension ChatMessage {
    
    static func getMessages(conversationId: String, onComplete: @escaping (_ messages: [ChatMessage]?, _ error: Error?) -> ()) {
        let listener = Database.shared.db.collection(collectionName.rawValue).whereField("conversationId", isEqualTo: conversationId).addSnapshotListener { (snapshot, error) in
            
            
            if let error = error {
                onComplete(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                onComplete(nil, nil)
                return
            }
            
            var objects = [ChatMessage]()
            for document in documents {
                do {
                    let obj = try document.decode(as: ChatMessage.self)
                    objects.append(obj)
                } catch {
                    print(error)
                    onComplete(nil, error)
                }
            }
            onComplete(objects, nil)
        }
        Database.shared.currentListener = listener
    }
}
