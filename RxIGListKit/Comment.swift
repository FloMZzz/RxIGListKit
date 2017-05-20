//
//  Comment.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit
import IGListKit

final class Comment: ListDiffable {
    let id: Int64
    let text: String
    
    init(id: Int64, text: String) {
        self.id = id
        self.text = text
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard object !== self else {
            return true
        }
        
        guard let comment = object as? Comment else {
            return false
        }
        
        return comment.id == id
    }
    
    static var comment: Comment {
        return Comment(id: 1, text: "First comment!!")
    }
}
