//
//  FeedViewController.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import Foundation
import IGListKit

final class FeedViewController: ListSectionController {
    
    fileprivate var feed: Feed?
    
    override init() {
        super.init()
        displayDelegate = self
        workingRangeDelegate = self
        scrollDelegate = self
        supplementaryViewSource = self
    }
}

extension FeedViewController {
    enum Kind: Int {
        case photo = 0
        case action
        case comment
        
        static var counts: Int {
            return 3
        }
    }
    
    override func numberOfItems() -> Int {
        return Kind.counts
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let feed = feed, let kind = Kind(rawValue: index), let containerSize = collectionContext?.containerSize else {
            fatalError("Feed & IGListCollectionContext are neccesory to display feed in \(self)")
        }
        
        let height: CGFloat
        switch kind {
        case .photo: height = (feed.photo.size.height * containerSize.width) / feed.photo.size.width
        case .action: height = 46
        case .comment: height = 26
        }
        
        return CGSize(width: containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let kind = Kind(rawValue: index) else { fatalError() }
        
        switch kind {
        case .photo:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedViewCell.nibName, bundle: nil, for: self, at: index) as! FeedViewCell
            cell.feed = feed
            return cell
            
        case .action:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedActionViewCell.nibName, bundle: nil, for: self, at: index) as! FeedActionViewCell
            return cell
            
        case .comment:
            let cell = collectionContext?.dequeueReusableCell(withNibName: FeedCommentViewCell.nibName, bundle: nil, for: self, at: index) as! FeedCommentViewCell
            cell.feed = feed
            return cell
        }
    }
    
    override func didUpdate(to object: Any) {
        feed = object as? Feed
    }
    
    override func didSelectItem(at index: Int) {
        print("Index \(index) is selected")
    }
}

extension FeedViewController: ListSupplementaryViewSource {
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

extension FeedViewController: ListScrollDelegate {
    func listAdapter(_ listAdapter: ListAdapter, didScroll sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willBeginDragging sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDragging sectionController: ListSectionController, willDecelerate decelerate: Bool) {
        
    }
}

extension FeedViewController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
        
    }
}

extension FeedViewController: ListDisplayDelegate {
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying sectionController: ListSectionController, cell: UICollectionViewCell, at index: Int) {
        
    }
}
