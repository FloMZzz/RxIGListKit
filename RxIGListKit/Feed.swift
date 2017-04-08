//
//  Feed.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

final class Feed: IGListDiffable {
    let id: Int64
    let user: User
    let comment: Comment
    let photo: UIImage
    
    init(id: Int64, user: User, comment: Comment, photo: UIImage) {
        self.id = id
        self.user = user
        self.comment = comment
        self.photo = photo
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard object !== self else {
            return true
        }
        
        guard let feed = object as? Feed else {
            return false
        }
        
        let isEqualFeed = feed.id == id
        let isEqualUser = user.isEqual(toDiffableObject: feed.user)
        let isEqualComment = comment.isEqual(toDiffableObject: feed.comment)
        
        return isEqualFeed && isEqualUser && isEqualComment
    }
    
    static var feeds: [Feed] {
        return [
            Feed(id: 1, user: User.user, comment: Comment.comment, photo: UIImage(named: "feed")!),
            Feed(id: 2, user: User.user, comment: Comment.comment, photo: UIImage(named: "feed1")!),
            Feed(id: 3, user: User.user, comment: Comment.comment, photo: UIImage(named: "feed2")!)
        ]
    }
}
