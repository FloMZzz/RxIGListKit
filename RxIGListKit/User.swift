//
//  User.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit
import IGListKit

final class User: ListDiffable {
    let id: Int64
    let name: String
    let profileImage: UIImage
    
    init(id: Int64, name: String, profileImage: UIImage) {
        self.id = id
        self.name = name
        self.profileImage = profileImage
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard object !== self else {
            return true
        }
        
        guard let user = object as? User else {
            return false
        }
        
        return user.id == id
    }
    
    static var user: User {
        return User(id: 1, name: "yuzushioh", profileImage: UIImage(named: "profile")!)
    }
}
