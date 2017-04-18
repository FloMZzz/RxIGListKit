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
