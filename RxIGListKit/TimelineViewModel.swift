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
    
    init() {
        disposeBag = DisposeBag()
        
        let feedsSubject = Variable<[Feed]>([])
        feeds = feedsSubject.asDriver()
        
        let appendedFeeds = Driver<Int>
            .interval(5.0)
            .map { _ in }
            .withLatestFrom(feedsSubject.asDriver())
            .map { $0 + Feed.feeds }
            
        appendedFeeds
            .filter { $0.count < 30 }
            .startWith(Feed.feeds)
            .do(onNext: { [weak self] in self?.latestFeeds = $0 })
            .drive(feedsSubject)
            .disposed(by: disposeBag)
    }
}
