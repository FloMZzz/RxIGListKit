//
//  UIViewController+Extension.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/09.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewDidLayoutSubviews: ControlEvent<Void> {
        let events = base.rx.sentMessage(#selector(UIViewController.viewDidLayoutSubviews))
            .map { _ in }
        
        return ControlEvent(events: events)
    }
}
