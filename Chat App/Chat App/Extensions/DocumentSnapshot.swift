//
//  DocumentSnapshit.swift
//  Chat App
//
//  Created by Mark bergeson on 9/5/21.
//

import Foundation
import FirebaseFirestore

enum DocumentSnapshotExtensionError: Error {
    case decodingError
}

extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        
        do {
            guard var documentJson = self.data() else {throw DocumentSnapshotExtensionError.decodingError}
            if includingId {
                documentJson["id"] = self.documentID
            }
            
            //transform any value in the data object as needed
            documentJson.forEach { (key: String, value: Any) in
            switch value {
            case _ as DocumentReference:
                documentJson.removeValue(forKey: key)
                break
            case let ts as Timestamp: // conver timestamp to value
                let date = ts.dateValue()
                
                let jsonValue = Int((date.timeIntervalSince1970 * 1000).rounded())
                documentJson[key] = jsonValue
                
                break
            default:
                break
            }
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        let decodedObject = try decoder.decode(objectType, from: documentData)
        
        return decodedObject
        
    } catch {
        throw error
        }
    }
}
