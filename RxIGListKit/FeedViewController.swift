//
//  FeedViewController.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import Foundation
import IGListKit

final class FeedViewController: IGListSectionController {
    
    fileprivate var feed: Feed?
    
    override init() {
        super.init()
        displayDelegate = self
        workingRangeDelegate = self
        scrollDelegate = self
        supplementaryViewSource = self
    }
}

extension FeedViewController: IGListSectionType {
    func numberOfItems() -> Int {
        return 3
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard let feed = feed, let context = collectionContext else {
            fatalError("Feed & IGListCollectionContext are neccesory to display feed in \(self)")
        }
        
        let containerWidth = context.containerSize.width
        switch index {
        case 0:
            let imageSize = feed.photo.size
            let height = (imageSize.height * containerWidth) / imageSize.width
            return CGSize(width: containerWidth, height: height)
            
        case 1: return CGSize(width: containerWidth, height: 46)
        case 2: return CGSize(width: containerWidth, height: 26)
        default: fatalError("Unexpected index for sizeForItem(at: _) in \(self)")
        }
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedViewCell.nibName, bundle: nil, for: self, at: index) as! FeedViewCell
            cell.feed = feed
            return cell
            
        case 1:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedActionViewCell.nibName, bundle: nil, for: self, at: index) as! FeedActionViewCell
            return cell
            
        case 2:
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

extension FeedViewController: IGListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let cell = collectionContext?.dequeueReusableSupplementaryView(
            ofKind: UICollectionElementKindSectionHeader, for: self, nibName: FeedUserViewCell.nibName, bundle: nil, at: index) as! FeedUserViewCell
        cell.feed = feed
        return cell
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 56)
    }
}

extension FeedViewController: IGListScrollDelegate {
    func listAdapter(_ listAdapter: IGListAdapter!, didScroll sectionController: IGListSectionController!) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, willBeginDragging sectionController: IGListSectionController!) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter!, didEndDragging sectionController: IGListSectionController!, willDecelerate decelerate: Bool) {
        
    }
}

extension FeedViewController: IGListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerWillEnterWorkingRange sectionController: IGListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerDidExitWorkingRange sectionController: IGListSectionController) {
        
    }
}

extension FeedViewController: IGListDisplayDelegate {
    func listAdapter(_ listAdapter: IGListAdapter, willDisplay sectionController: IGListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, didEndDisplaying sectionController: IGListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, willDisplay sectionController: IGListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, didEndDisplaying sectionController: IGListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
}
