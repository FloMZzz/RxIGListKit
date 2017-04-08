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
    
    fileprivate var viewModel: TimelineViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        
        viewModel = TimelineViewModel(
            scrolledToBottom: collectionView.rx.scrolledToBottom.asDriver()
        )
        
        adapter.dataSource = self
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func bind() {
        viewModel.feeds
            .drive(onNext: { [weak self] _ in self?.adapter.performUpdates(animated: true, completion: nil) })
            .disposed(by: disposeBag)
    }
}

extension TimelineViewController: IGListAdapterDataSource {
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return viewModel.latestFeeds
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return FeedViewController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}
