//
//  UITableViewCell.swift
//  Chat App
//
//  Created by Mark bergeson on 9/19/21.
//

import UIKit

extension UITableViewCell {
    
    class func reusIdentifier() -> String {
        return String(describing: self)
    }
}


