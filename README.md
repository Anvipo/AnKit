# AnKit

AnKit is an UIKit wrapper library written in pure Swift

## Usage

### Base example

```swift
import AnKit
import UIKit

final class SimpleVC: UIViewController {
	private lazy var collectionView = CollectionView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fillCollectionView()
	}
}

private extension SimpleVC {
	func setupUI() {
		view.backgroundColor = .systemBackground

		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func makeItem(text: String) throws -> CollectionViewItem {
		try PlainLabelItem(
			text: text,
			textColor: .label,
			textFont: .preferredFont(forTextStyle: .title1),
			tintColor: .systemIndigo,
			textAlignment: .center,
			textInsets: NSDirectionalEdgeInsets(
				horizontalInset: .defaultHorizontalOffset,
				verticalInset: 8
			),
			dividerModel: .lineDefaultOffsetFromStart(color: .systemRed)
		)
	}

	func fillCollectionView() {
		do {
			let section = try PlainListSection(
				items: [
					try makeItem(text: "Text 1"),
					try makeItem(text: "Text 2"),
					try makeItem(text: "Text 3"),
					try makeItem(text: "Text 4"),
					try makeItem(text: "Text 5")
				]
			)

			try collectionView.set(
				sections: [section],
				animatingDifferences: false
			)
		} catch {
			assertionFailure(error.localizedDescription)
		}
	}
}
```
### More examples

There is more examples in `Playground` folder, just go and see it

## Features

- [x] `UICollectionViewDiffableDataSource` wrappers for easy use ViewModel-View pattern in Swift way
- [x] `UICollectionViewCompositionalLayout` wrappers for easy use `UICollectionView` in all your screens
- [x] Ready plain sections, spacer, shimmer & label items 
- [x] `UICollectionViewDataSourcePrefetching` support
- [x] Additional `UIKit` wrappers for constraints, blurred views, layer shadows and others

### Create custom sections
You can create custom sections and do any layout what you want.
Just create new class, inherit it from `CollectionViewSection` and override `layoutConfiguration` method to implement.
For example, see `PlainListSection` in `Sources` folder.

### Create custom items for cells
You can create custom items and do any cells, which inherits from `CollectionViewCell`.
Just create new class, inherit it from `CollectionViewItem` and override `cellType` property to implement.
For example, see `PlainLabelItem` in `Sources` folder.

### Create custom items for supplementary views
You can create custom items and do any supplementary views, which inherits from `CollectionViewSupplementaryView`.
Just create new class, inherit it from `CollectionViewSupplementaryItem` and override `supplementaryViewType` property to implement.
For example, see `PlainLabelBoundarySupplemetaryItem` in `Sources` folder.

### Create custom background items for section
You can create custom background items for each section in your collection view.
Just create new class, inherit it from `CollectionViewDecorationItem` and override `decorationViewType` property to implement.
For example, see `SecondarySystemGroupedBackgroundDecorationItem` in `Sources` folder.

### Create custom transaction to collection view's snapshot data
You can provide custom transaction to collection view's snapshot data.
Just call `apply(snapshotTransaction:animatingDifferences:)` method
and pass to `snapshotTransaction` parameter any array of `CollectionView.SnapshotAction`.

### Convenient `BaseVC`
Also, there is `BaseVC` for convenient methods, which you could need in your `UIViewController`s.
Just inherit `BaseVC` in your view controller.
For example, see `ShuffleItemsVC` and `SectionBackgroundVC` in `Playground` folder.

### Other examples
See more screen examples in `Playground` folder.

## Requirements

iOS 13.0+

## Installation

### Manually

#### By binary

- Download `AnKit` project
- Open `.xcodeproj` file, choose `Create-XCFramework-scripts` target and press build target (by default key bindings click `command + B`)
- After success build it will open folder with built `.xcframework` binary file
- Open your `.xcodeproj` file
- Go to `Project Navigator` (by default key bindings click `command + 1`)
- Click on your project
- Go to `Your target` -> `General` tab
- Drag that `.xcframework` binary file in `Framework, Libraries` section
- Build your project (by default key bindings click `command + B`)
- Write `import AnKit` in your Swift file
- Enjoy 

> After once you added link to `.xcframework` in `Framework,Libraries` section,
you can delete previous version and just copy `.xcframework` binary file into same place in your project,
where previous `.xcframework` binary lay,
clean `DerivedData` folder and build your project.
New changes will work automatically.

#### By sources

- Just copy & link sources into your project (for better use, in standalone folder)

## License

AnKit is released under the MIT license. See LICENSE for details.

## Author

Andrey Popov (Anvipo)

My e-mail:
<anvipo.apps@gmail.com>

My Telegram:
@Anvipo (https://t.me/Anvipo)
