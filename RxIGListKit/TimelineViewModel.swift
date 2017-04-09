//
//  TimelineViewModel.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/09.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class TimelineViewModel {
    
    private let disposeBag: DisposeBag
    
    let feeds: Driver<[Feed]>
    private(set) var latestFeeds: [Feed] = []
    
    init(scrolledToBottom: Driver<Void>) {
        disposeBag = DisposeBag()
        
        let feedsSubject = Variable<[Feed]>([])
        feeds = feedsSubject.asDriver()
            
        let appendedFeeds = scrolledToBottom
            .withLatestFrom(feedsSubject.asDriver())
            .map { $0 + Feed.feeds }
            .startWith(Feed.feeds)
            
        appendedFeeds
            .do(onNext: { [weak self] in self?.latestFeeds = $0 })
            .drive(feedsSubject)
            .disposed(by: disposeBag)
    }
}
