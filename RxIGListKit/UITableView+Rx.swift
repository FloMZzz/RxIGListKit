//
//  UITableView+Rx.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/18.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import RxSwift
import IGListKit
import RxCocoa

extension Reactive where Base: UITableView {
    func items<S: Sequence, Cell: UITableViewCell, O: ObservableType>
        (cellIdentifier: String, cellType: Cell.Type = Cell.self)
        -> (_ source: O)
        -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
        -> Disposable
        where S.Iterator.Element: IGListDiffable, O.E == S {
            
            return { source in
                return { configureCell in
                    let dataSource = RxTableViewReactiveDiffableArrayDataSourceSequenceWrapper<S> { (tableView, i, item) in
                        let indexPath = IndexPath(item: i, section: 0)
                        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
                        configureCell(i, item, cell)
                        return cell
                    }
                    return self.items(dataSource: dataSource)(source)
                }
            }
    }
}
