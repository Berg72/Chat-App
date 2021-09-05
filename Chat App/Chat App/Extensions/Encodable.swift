//
//  Encodable.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation
import FirebaseFirestore
import Firebase
import CodableFirebase

enum EncodableExtensionError: Error {
    case encodingError
}

extension DocumentReference: DocumentReferenceType {}
extension GeoPoint: GeoPointType {}
extension FieldValue: FieldValueType {}
extension Timestamp: TimestampType {}

extension Encodable {
    
    /**
    Serialize an object to a form that can be persisted to Firebase. By default it will ignore th ID string Functionallity is primarily provided by the CodableFirebase library
     [https://github.com/alickbass/CodableFirebase]
     */
    func toFirestoreData(excluding excludedKeys: [String] = ["id"] ) throws -> [String: Any] {
        
        let encoder = FirestoreEncoder()
        var docData = try! encoder.encode(self)
        
        for key in excludedKeys {
            docData.removeValue(forKey: key)
        }
        
        return docData
        
    }
    
}
