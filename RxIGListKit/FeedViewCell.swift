//
//  FeedViewCell.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit

final class FeedViewCell: UICollectionViewCell {
    
    static let nibName = String(describing: FeedViewCell.self)
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    var feed: Feed? {
        didSet {
            guard let feed = feed else {
                return
            }
            feedImageView.image = feed.photo
        }
    }
}
