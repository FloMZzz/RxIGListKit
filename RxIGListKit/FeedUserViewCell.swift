//
//  FeedUserViewCell.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit

final class FeedUserViewCell: UICollectionViewCell {
    
    static let nibName = String(describing: FeedUserViewCell.self)
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var feed: Feed? {
        didSet {
            guard let user = feed?.user else {
                return
            }
            
            profileImageView.image = user.profileImage
            usernameLabel.text = user.name
        }
    }
}
