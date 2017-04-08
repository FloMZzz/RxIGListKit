//
//  FeedViewController.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import Foundation
import IGListKit

final class FeedViewController: IGListSectionController, IGListSectionType {
    
    private var feed: Feed?
    
    func numberOfItems() -> Int {
        return 4
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let feed = feed, let context = collectionContext else {
            fatalError("Feed & IGListCollectionContext are neccesory to display feed in \(self)")
        }
        
        let containerWidth = context.containerSize.width
        
        switch index {
        case 0:
            return CGSize(width: containerWidth, height: 56)
            
        case 1:
            let imageSize = feed.photo.size
            let height = (imageSize.height * containerWidth) / imageSize.width
            return CGSize(width: containerWidth, height: height)
            
        case 2:
            return CGSize(width: containerWidth, height: 46)
            
        case 3:
            return CGSize(width: containerWidth, height: 26)
            
        default:
            fatalError("Unexpected index for sizeForItem(at: _) in \(self)")
        }
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedUserViewCell.nibName, bundle: nil, for: self, at: index) as! FeedUserViewCell
            cell.feed = feed
            return cell
            
        case 1:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedViewCell.nibName, bundle: nil, for: self, at: index) as! FeedViewCell
            cell.feed = feed
            return cell
            
        case 2:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedActionViewCell.nibName, bundle: nil, for: self, at: index) as! FeedActionViewCell
            return cell
            
        case 3:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedCommentViewCell.nibName, bundle: nil, for: self, at: index) as! FeedCommentViewCell
            cell.feed = feed
            return cell
            
        default:
            fatalError()
        }
    }
    
    func didUpdate(to object: Any) {
        feed = object as? Feed
    }
    
    func didSelectItem(at index: Int) {
        print("Index \(index) is selected")
    }
}
