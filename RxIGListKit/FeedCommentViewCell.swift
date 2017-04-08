//
//  FeedCommentViewCell.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit

final class FeedCommentViewCell: UICollectionViewCell {
    
    static let nibName = String(describing: FeedCommentViewCell.self)
    
    @IBOutlet weak var commentLabel: UILabel!
    
    var feed: Feed? {
        didSet {
            guard let feed = feed else {
                return
            }
            commentLabel.text = feed.comment.text
        }
    }
}
