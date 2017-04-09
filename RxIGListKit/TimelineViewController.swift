//
//  TimelineViewController.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/08.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit

final class TimelineViewController: UIViewController {
    
    lazy private var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    }()
    
    private let collectionView = IGListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let disposeBag = DisposeBag()
    private let dataSource = DataSource()
    
    fileprivate var viewModel: TimelineViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        
        viewModel = TimelineViewModel(
            scrolledToBottom: collectionView.rx.scrolledToBottom.asDriver()
        )
        
        rx.viewDidLayoutSubviews.asDriver()
            .drive(onNext: { [unowned self] _ in self.collectionView.frame = self.view.bounds })
            .disposed(by: disposeBag)
        
        adapter.rx.setDataSource(dataSource)
            .disposed(by: disposeBag)
        
        viewModel.feeds
            .drive(adapter.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    final class DataSource: NSObject, IGListAdapterDataSource, RxIGListAdapterDataSource {
        typealias Element = [Feed]
        
        var elements: Element = []
        
        func listAdapter(_ adapter: IGListAdapter, observedEvent: Event<[Feed]>) {
            if case .next(let feeds) = observedEvent {
                elements = feeds
                adapter.performUpdates(animated: true)
            }
        }
        
        func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
            return elements
        }
        
        func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
            return FeedViewController()
        }
        
        func emptyView(for listAdapter: IGListAdapter) -> UIView? {
            return nil
        }
    }
}
