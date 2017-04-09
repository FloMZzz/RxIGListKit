# RxIGListKit

This library wraps IGListAdapter in [IGListKit](https://github.com/Instagram/IGListKit) with RxSwift like UICollectionView and UITableView. Trying to use IGListKit with RxSwift and to find a better way to improve it🚀 not ready for production🙅


## Example
I implemented Instagram UI with RxSwift and IGListKit in the same way Instagram feed is implemented - [detail](https://realm.io/news/tryswift-ryan-nystrom-refactoring-at-scale-lessons-learned-rewriting-instagram-feed/)

To see, clone this repository and run!


<img src="https://cloud.githubusercontent.com/assets/12425729/24835650/304e1cfe-1d42-11e7-8489-3f8b8c16d4c6.PNG" width="340"> | <img src="https://cloud.githubusercontent.com/assets/12425729/24835665/84d55f44-1d42-11e7-8666-408cda9f536a.PNG" width="340">

## How to use

Create a dataSource comfirmed to RxIGListAdapterDataSource and IGListAdapterDataSource and use it like UICollectionView and UITableView in RxSwift🎉

```swift

lazy privatevar adapter: IGListAdapter = {
    return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 2)
}()

private let disposeBag = DisposeBag()
private let dataSource = DataSource()

override func viewDidLoad() {
    super.viewDidLoad()
    
    adapter.rx.setDataSource(dataSource)
        .disposed(by: disposeBag)

    viewModel.feeds
        .drive(adapter.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
}
```

```swift
final class DataSource: NSObject, IGListAdapterDataSource, RxIGListAdapterDataSource {
    typealias Element = [Foo]
    var elements: Element = []

    func listAdapter(_ adapter: IGListAdapter, observedEvent: Event<Element>) {
        if case .next(let elements) = observedEvent {
            self.elements = elements
            adapter.performUpdates(animated: true)
        }
    }

    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return elements
    }

    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return SectionController()
    }

    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}
```

## Help
I am trying to find a good way to wrap up IGListSectionViewController and its delegates. it would be very appriciated to make an issue or PR!
