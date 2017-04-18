//
//  RxTableViewReactiveDiffableArrayDataSource.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/18.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa

class _RxTableViewReactiveDiffableArrayDataSource: NSObject, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func _tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableView(tableView, numberOfRowsInSection: section)
    }
    
    func _tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return _tableView(tableView, cellForRowAt: indexPath)
    }
}

class RxTableViewReactiveDiffableArrayDataSourceSequenceWrapper<S: Sequence>
    : RxTableViewReactiveDiffableArrayDataSource<S.Iterator.Element>,
    RxTableViewDataSourceType where S.Iterator.Element: IGListDiffable {
    
    typealias Element = S
    
    override init(cellFactory: @escaping CellFactory) {
        super.init(cellFactory: cellFactory)
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<S>) {
        UIBindingObserver(UIElement: self) { tableViewDataSource, sectionModels in
                let sections = Array(sectionModels)
                tableViewDataSource.tableView(tableView, observedElements: sections)
            }
            .on(observedEvent)
    }
}

class RxTableViewReactiveDiffableArrayDataSource<Element: IGListDiffable>
    : _RxTableViewReactiveDiffableArrayDataSource,
    SectionedViewDataSourceType {
    
    typealias CellFactory = (UITableView, Int, Element) -> UITableViewCell
    
    var elements: [Element] = []
    
    func modelAtIndex(_ index: Int) -> Element? {
        return elements[index]
    }
    
    func model(at indexPath: IndexPath) throws -> Any {
        return elements[indexPath.row]
    }
    
    let cellFactory: CellFactory
    
    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory
    }
    
    override func _tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func _tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactory(tableView, indexPath.item, elements[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, observedElements: [Element]) {
        let from = elements
        let to = observedElements
        elements = observedElements
        
        let result = IGListDiffPaths(0, 0, from, to, .equality).forBatchUpdates()
        
        tableView.beginUpdates()
        tableView.deleteRows(at: result.deletes, with: .fade)
        tableView.insertRows(at: result.inserts, with: .fade)
        result.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
        tableView.endUpdates()
    }
}
