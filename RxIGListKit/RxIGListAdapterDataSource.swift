//
//  RxIGListAdapterDataSource.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/09.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import RxSwift
import IGListKit
import RxCocoa

protocol RxIGListAdapterDataSource {
    associatedtype Element
    func listAdapter(_ adapter: IGListAdapter, observedEvent: Event<Element>) -> Void
}

extension Reactive where Base: IGListAdapter {
    func items<DataSource: RxIGListAdapterDataSource & IGListAdapterDataSource, O: ObservableType>(dataSource: DataSource)
        -> (_ source: O)
        -> Disposable where DataSource.Element == O.E {
            
        return { source in
            let subscription = source
                .subscribe { dataSource.listAdapter(self.base, observedEvent: $0) }
            
            return Disposables.create {
                subscription.dispose()
            }
        }
    }
    
    func setDataSource<DataSource: RxIGListAdapterDataSource & IGListAdapterDataSource>(_ dataSource: DataSource) -> Disposable {
        base.dataSource = dataSource
        return Disposables.create()
    }
}
