//
//  User.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation

struct User: CPObject {
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


extension User {
    
    static func getUser(userId: String, onComplete: @escaping (_ user: User?, _ error: Error?) -> ()) {
        Database.shared.db.collection(collectionName.rawValue).document(userId).getDocument { snapshot, error in
            if let error = error {
                onComplete(nil, error)
                return
            }
            
            guard let document = snapshot else {
                onComplete(nil, nil)
                return
            }
            
            do {
                let obj = try document.decode(as: User.self)
                onComplete(obj, nil)
            } catch {
                print(error)
                onComplete(nil, error)
            }
            
        }
    }
    
    static func getUsers(onComplete: @escaping (_ users: [User]?, _ error: Error?) -> ()) {
        Database.shared.db.collection(collectionName.rawValue).getDocuments { (snapshot, error) in
            if let error = error {
                onComplete(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                onComplete(nil, nil)
                return
            }
            
            var objects = [User]()
            for document in documents {
                do {
                    let obj = try document.decode(as: User.self)
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
