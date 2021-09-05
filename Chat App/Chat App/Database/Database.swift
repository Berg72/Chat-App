//
//  Database.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum CollectionName: String {
    case User
    case ChatMessage
    case Conversation
}

protocol CPObject: Codable {
    static var collectionName: CollectionName { get }
    var id: String? {get set}
    var created: Double {get set}
    var createdBy: String {get set}
    var lastUpdated: Double {get set}
    var lastUpdatedBy: String {get set}
    var archived: Bool {get set}
    var archivedAt: Double? { get set}
}

class Database {
    static let shared = Database()
    let db: Firestore
    
    var currentUser: User?
    
    private init() {
        let firestoreSettings = FirestoreSettings()
        firestoreSettings.isPersistenceEnabled = false
        
        self.db = Firestore.firestore()
    }
}

// Mark: Helpers
private extension Database {
    
    func getCollection(_ obj:CPObject) -> CollectionReference {
        return getCollection(type(of: obj).collectionName)
    }
    
    func getCollection(_ name: CollectionName) -> CollectionReference {
        return db.collection(name.rawValue)
    }
    
    func getDocumentRef(_ obj: CPObject) -> DocumentReference {
        let collection = getCollection(obj)
        
        if let id = obj.id {
            return collection.document(id)
        }
        else {
            return collection.document()
        }
    }
}

// Mark: Save
extension Database {
    
    func save<T: CPObject>(_ object: T, onComplete: @escaping (_ savedObject: T?, _ error: Error? ) -> Void) {
        
        var obj = object
        obj.lastUpdated = Date().timeIntervalSince1970
        obj.lastUpdatedBy = Auth.auth().currentUser?.uid ?? ""
        let ref = getDocumentRef(obj)
        do {
            let data = try obj.toFirestoreData()
            ref.setData(data, merge: true) { (error) in
                var savedObject = obj
                savedObject.id = ref.documentID
                if let error = error {
                    onComplete(nil, error)
                }
                onComplete(savedObject, error)
            }
        } catch {
            onComplete(nil, error)
        }
    }
}
