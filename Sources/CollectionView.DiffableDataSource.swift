//
//  CollectionView.DiffableDataSource.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//
// swiftlint:disable file_length

import UIKit

extension CollectionView {
	@MainActor
	final class DiffableDataSource: UICollectionViewDiffableDataSource<
		CollectionViewSection,
		CollectionViewItem
	> {
		weak var scrollViewDelegate: UIScrollViewDelegate?
		weak var prefetchingDelegate: CollectionViewPrefetchingDelegate?

		init(collectionView: CollectionView) {
			super.init(collectionView: collectionView) { collectionView, indexPath, item in
				Self.cellProvider(collectionView: collectionView, indexPath: indexPath, item: item)
			}

			collectionView.delegate = self
			collectionView.prefetchDataSource = self

			supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
				guard let self = self else {
					return nil
				}

				return self.supplementaryView(
					collectionView: collectionView,
					kind: kind,
					indexPath: indexPath
				)
			}
		}
	}
}

extension CollectionView.DiffableDataSource {
	var isDataEmpty: Bool {
		snapshot().numberOfSections == 0
	}
}

// MARK: - set(sections:animatingDifferences:)
extension CollectionView.DiffableDataSource {
	func set(
		sections: [CollectionViewSection],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		var newSnapshot = Snapshot()
		try append(sections: sections, to: &newSnapshot)

		apply(
			newSnapshot,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	@available(iOS 15, *)
	func set(
		sections: [CollectionViewSection],
		animatingDifferences: Bool
	) async throws {
		var newSnapshot = Snapshot()
		try append(sections: sections, to: &newSnapshot)

		await apply(newSnapshot, animatingDifferences: animatingDifferences)
	}
}

// MARK: - reload(items:animatingDifferences:)
extension CollectionView.DiffableDataSource {
	func reload(
		items: [CollectionViewItem],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		if items.isEmpty {
			completion?()
			return
		}

		var currentSnapshot = snapshot()

		for item in items {
			if currentSnapshot.indexOfItem(item) == nil {
				throw CollectionView.DataSourceError.notExistingItem(item)
			}
		}

		currentSnapshot.reloadItems(items)

		apply(
			currentSnapshot,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	@available(iOS 15, *)
	func reload(
		items: [CollectionViewItem],
		animatingDifferences: Bool
	) async throws {
		if items.isEmpty {
			return
		}

		var currentSnapshot = snapshot()

		for item in items {
			if currentSnapshot.indexOfItem(item) == nil {
				throw CollectionView.DataSourceError.notExistingItem(item)
			}
		}

		currentSnapshot.reloadItems(items)

		await apply(currentSnapshot, animatingDifferences: animatingDifferences)
	}
}

// MARK: - reconfigure(items:animatingDifferences:)
extension CollectionView.DiffableDataSource {
	@available(iOS 15, *)
	func reconfigure(
		items: [CollectionViewItem],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		if items.isEmpty {
			completion?()
			return
		}

		var currentSnapshot = snapshot()

		for item in items {
			if currentSnapshot.indexOfItem(item) == nil {
				throw CollectionView.DataSourceError.notExistingItem(item)
			}
		}

		currentSnapshot.reconfigureItems(items)

		apply(
			currentSnapshot,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	@available(iOS 15, *)
	func reconfigure(
		items: [CollectionViewItem],
		animatingDifferences: Bool
	) async throws {
		if items.isEmpty {
			return
		}

		var currentSnapshot = snapshot()

		for item in items {
			if currentSnapshot.indexOfItem(item) == nil {
				throw CollectionView.DataSourceError.notExistingItem(item)
			}
		}

		currentSnapshot.reconfigureItems(items)

		await apply(currentSnapshot, animatingDifferences: animatingDifferences)
	}
}

// MARK: - reload(sections:animatingDifferences:)
extension CollectionView.DiffableDataSource {
	func reload(
		sections: [CollectionViewSection],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		if sections.isEmpty {
			completion?()
			return
		}

		var currentSnapshot = snapshot()

		for section in sections {
			if currentSnapshot.indexOfSection(section) == nil {
				throw CollectionView.DataSourceError.notExistingSection(section)
			}
		}

		currentSnapshot.reloadSections(sections)

		apply(
			currentSnapshot,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	@available(iOS 15, *)
	func reload(
		sections: [CollectionViewSection],
		animatingDifferences: Bool
	) async throws {
		if sections.isEmpty {
			return
		}

		var currentSnapshot = snapshot()

		for section in sections {
			if currentSnapshot.indexOfSection(section) == nil {
				throw CollectionView.DataSourceError.notExistingSection(section)
			}
		}

		currentSnapshot.reloadSections(sections)

		await apply(currentSnapshot, animatingDifferences: animatingDifferences)
	}
}

// MARK: - apply(snapshotTransaction:animatingDifferences:)
extension CollectionView.DiffableDataSource {
	// swiftlint:disable:next cyclomatic_complexity function_body_length
	func apply(
		snapshotTransaction: CollectionView.SnapshotTransaction,
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		if snapshotTransaction.isEmpty {
			completion?()
			return
		}

		var currentSnapshot = snapshot()

		for action in snapshotTransaction {
			switch action {
			case let .setSections(sections):
				currentSnapshot = Snapshot()

				try append(sections: sections, to: &currentSnapshot)

			case let .deleteSections(sections):
				if sections.isEmpty {
					completion?()
					return
				}

				currentSnapshot.deleteSections(sections)

			case let .appendSections(sections):
				if sections.isEmpty {
					completion?()
					return
				}

				try append(sections: sections, to: &currentSnapshot)

			case let .appendItems(items, toSection):
				if items.isEmpty {
					completion?()
					return
				}

				for item in items {
					if let index = currentSnapshot.indexOfItem(item) {
						throw CollectionView.DataSourceError.existingItem(
							item,
							itemIndexInSnapshot: index
						)
					}
				}

				currentSnapshot.appendItems(items, toSection: toSection)

			case let .deleteItems(items):
				if items.isEmpty {
					completion?()
					return
				}

				currentSnapshot.deleteItems(items)

			case let .insertItemsAfterItem(items, afterItem):
				if currentSnapshot.indexOfItem(afterItem) == nil {
					throw CollectionView.DataSourceError.notExistingItem(afterItem)
				}

				if items.isEmpty {
					completion?()
					return
				}

				for item in items {
					if let index = currentSnapshot.indexOfItem(item) {
						throw CollectionView.DataSourceError.existingItem(
							item,
							itemIndexInSnapshot: index
						)
					}
				}

				let uniqueByID = items.unique { $0.id }

				if items.count != uniqueByID.count {
					throw CollectionView.DataSourceError.notUniqueItems(items)
				}

				currentSnapshot.insertItems(items, afterItem: afterItem)

			case let .insertSectionsAfterSection(sections, afterSection):
				if currentSnapshot.indexOfSection(afterSection) == nil {
					throw CollectionView.DataSourceError.notExistingSection(afterSection)
				}

				if sections.isEmpty {
					completion?()
					return
				}

				for section in sections {
					if let index = currentSnapshot.indexOfSection(section) {
						throw CollectionView.DataSourceError.existingSection(
							section,
							sectionIndexInSnapshot: index
						)
					}
				}

				let uniqueByID = sections.unique { $0.id }

				if sections.count != uniqueByID.count {
					throw CollectionView.DataSourceError.notUniqueSections(sections)
				}

				currentSnapshot.insertSections(sections, afterSection: afterSection)

			case let .reloadItems(items):
				if items.isEmpty {
					completion?()
					return
				}

				for item in items {
					if currentSnapshot.indexOfItem(item) == nil {
						throw CollectionView.DataSourceError.notExistingItem(item)
					}
				}

				currentSnapshot.reloadItems(items)

			case let .reloadSections(sections):
				if sections.isEmpty {
					completion?()
					return
				}

				for section in sections {
					if currentSnapshot.indexOfSection(section) == nil {
						throw CollectionView.DataSourceError.notExistingSection(section)
					}
				}

				currentSnapshot.reloadSections(sections)

			case let .reconfigureItems(items):
				if items.isEmpty {
					completion?()
					return
				}

				for item in items {
					if currentSnapshot.indexOfItem(item) == nil {
						throw CollectionView.DataSourceError.notExistingItem(item)
					}
				}

				if #available(iOS 15.0, *) {
					currentSnapshot.reconfigureItems(items)
				}

			case let .reconfigureOrReloadItems(items):
				if items.isEmpty {
					completion?()
					return
				}

				for item in items {
					if currentSnapshot.indexOfItem(item) == nil {
						throw CollectionView.DataSourceError.notExistingItem(item)
					}
				}

				if #available(iOS 15.0, *) {
					currentSnapshot.reconfigureItems(items)
				} else {
					currentSnapshot.reloadItems(items)
				}
			}
		}

		apply(
			currentSnapshot,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	@available(iOS 15, *)
	// swiftlint:disable:next cyclomatic_complexity function_body_length
	func apply(
		snapshotTransaction: CollectionView.SnapshotTransaction,
		animatingDifferences: Bool
	) async throws {
		if snapshotTransaction.isEmpty {
			return
		}

		var currentSnapshot = snapshot()

		for action in snapshotTransaction {
			switch action {
			case let .setSections(sections):
				currentSnapshot = Snapshot()

				try append(sections: sections, to: &currentSnapshot)

			case let .deleteSections(sections):
				if sections.isEmpty {
					return
				}

				currentSnapshot.deleteSections(sections)

			case let .appendSections(sections):
				if sections.isEmpty {
					return
				}

				try append(sections: sections, to: &currentSnapshot)

			case let .deleteItems(items):
				if items.isEmpty {
					return
				}

				currentSnapshot.deleteItems(items)

			case let .appendItems(items, toSection):
				if items.isEmpty {
					return
				}

				for item in items {
					if let index = currentSnapshot.indexOfItem(item) {
						throw CollectionView.DataSourceError.existingItem(
							item,
							itemIndexInSnapshot: index
						)
					}
				}

				currentSnapshot.appendItems(items, toSection: toSection)

			case let .reloadSections(sections):
				if sections.isEmpty {
					return
				}

				for section in sections {
					if currentSnapshot.indexOfSection(section) == nil {
						throw CollectionView.DataSourceError.notExistingSection(section)
					}
				}

				currentSnapshot.reloadSections(sections)

			case let .insertItemsAfterItem(items, afterItem):
				if currentSnapshot.indexOfItem(afterItem) == nil {
					throw CollectionView.DataSourceError.notExistingItem(afterItem)
				}

				if items.isEmpty {
					return
				}

				for item in items {
					if let index = currentSnapshot.indexOfItem(item) {
						throw CollectionView.DataSourceError.existingItem(
							item,
							itemIndexInSnapshot: index
						)
					}
				}

				let uniqueByID = items.unique { $0.id }

				if items.count != uniqueByID.count {
					throw CollectionView.DataSourceError.notUniqueItems(items)
				}

				currentSnapshot.insertItems(items, afterItem: afterItem)

			case let .insertSectionsAfterSection(sections, afterSection):
				if currentSnapshot.indexOfSection(afterSection) == nil {
					throw CollectionView.DataSourceError.notExistingSection(afterSection)
				}

				if sections.isEmpty {
					return
				}

				for section in sections {
					if let index = currentSnapshot.indexOfSection(section) {
						throw CollectionView.DataSourceError.existingSection(
							section,
							sectionIndexInSnapshot: index
						)
					}
				}

				let uniqueByID = sections.unique { $0.id }

				if sections.count != uniqueByID.count {
					throw CollectionView.DataSourceError.notUniqueSections(sections)
				}

				currentSnapshot.insertSections(sections, afterSection: afterSection)

			case let .reloadItems(items):
				if items.isEmpty {
					return
				}

				for item in items {
					if currentSnapshot.indexOfItem(item) == nil {
						throw CollectionView.DataSourceError.notExistingItem(item)
					}
				}

				currentSnapshot.reloadItems(items)

			case let .reconfigureItems(items),
				 let .reconfigureOrReloadItems(items):
				if items.isEmpty {
					return
				}

				for item in items {
					if currentSnapshot.indexOfItem(item) == nil {
						throw CollectionView.DataSourceError.notExistingItem(item)
					}
				}

				currentSnapshot.reconfigureItems(items)
			}
		}

		await apply(currentSnapshot, animatingDifferences: animatingDifferences)
	}
}

// MARK: - <UIScrollViewDelegate>
extension CollectionView.DiffableDataSource: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		scrollViewDelegate?.scrollViewDidScroll?(scrollView)
	}
}

// MARK: - <UICollectionViewDelegate>
extension CollectionView.DiffableDataSource: UICollectionViewDelegate {
	func collectionView(
		_ collectionView: UICollectionView,
		didEndDisplaying cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		guard let imageProviders = (cell as? HasImageProviders)?.imageProviders else {
			return
		}

		if imageProviders.isEmpty {
			return
		}

		for imageProvider in imageProviders {
			imageProvider.cancelRequest()
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		didSelectItemAt indexPath: IndexPath
	) {
		guard let tappableItem = itemIdentifier(for: indexPath) as? Tappable else {
			return
		}

		if !tappableItem.canResponseToTap {
			return
		}

		tappableItem.onTap?()
	}
}

// MARK: - <UICollectionViewDataSourcePrefetching>
extension CollectionView.DiffableDataSource: UICollectionViewDataSourcePrefetching {
	func collectionView(
		_ collectionView: UICollectionView,
		prefetchItemsAt indexPaths: [IndexPath]
	) {
		if let prefetchingDelegate = prefetchingDelegate,
		   let collectionView = collectionView as? CollectionView {
			prefetchingDelegate.collectionView(
				collectionView,
				prefetchItemsAt: indexPaths
			)
		}

		let imageProviders = imageProviders(for: indexPaths)

		if imageProviders.isEmpty {
			return
		}

		for imageProvider in imageProviders {
			imageProvider.prefetch()
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cancelPrefetchingForItemsAt indexPaths: [IndexPath]
	) {
		let imageProviders = imageProviders(for: indexPaths)

		if imageProviders.isEmpty {
			return
		}

		for imageProvider in imageProviders {
			imageProvider.cancelPrefetching()
		}
	}
}

// MARK: - Private methods
private extension CollectionView.DiffableDataSource {
	typealias Snapshot = NSDiffableDataSourceSnapshot<
		CollectionViewSection,
		CollectionViewItem
	>

	static func cellProvider(
		collectionView: UICollectionView,
		indexPath: IndexPath,
		item: CollectionViewItem
	) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: item.cellType.reuseIdentifier,
			for: indexPath
		)

		guard let castedCell = cell as? CollectionViewCell else {
			fatalError(
				"""
				Cell \(cell) should inherit CollectionViewCell.
				Collection view: \(collectionView)
				Index path: \(indexPath)
				Item: \(item)
				"""
			)
		}

		guard let collectionView = collectionView as? CollectionView else {
			fatalError(
				"""
				Collection view \(collectionView) should inherit CollectionView
				Cell: \(cell)
				Index path: \(indexPath)
				Item: \(item)
				"""
			)
		}

		castedCell.fill(
			from: item,
			context: CollectionViewCell.FillContext(
				availableWidth: collectionView.bounds.width,
				availableHeight: collectionView.bounds.height
			)
		)

		return cell
	}

	func supplementaryView(
		collectionView: UICollectionView,
		kind: String,
		indexPath: IndexPath
	) -> UICollectionReusableView {
		guard let section = snapshot().sectionIdentifiers[safe: indexPath.section] else {
			fatalError(
				"""
				Snapshot must have specified section at index path \(indexPath)
				Collection view: \(collectionView)
				Kind: \(kind)
				Index path: \(indexPath)
				"""
			)
		}

		guard let supplementaryItem = section.supplementaryItem(for: kind) else {
			fatalError(
				"""
				Section must have layout with same element kinds like in supplementaryItems.
				Kind (\(kind)) did not found in section's (\(section)) supplementaryItems for index path \(indexPath)
				in collectionView \(collectionView).
				"""
			)
		}

		let supplementaryView = collectionView.dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: supplementaryItem.supplementaryViewType.reuseIdentifier,
			for: indexPath
		)

		guard let castedSupplementaryView = supplementaryView as? CollectionViewSupplementaryView else {
			fatalError(
				"""
				Supplementary view \(supplementaryView) should inherit CollectionViewSupplementaryView
				Collection view: \(collectionView)
				Kind: \(kind)
				Index path: \(indexPath)
				Item: \(supplementaryItem)
				"""
			)
		}

		castedSupplementaryView.fill(
			from: supplementaryItem,
			context: CollectionViewSupplementaryView.FillContext(
				availableWidth: collectionView.bounds.width,
				availableHeight: collectionView.bounds.height
			)
		)

		return supplementaryView
	}

	func append(
		sections: [CollectionViewSection],
		to snapshot: inout Snapshot
	) throws {
		for section in sections {
			if let index = snapshot.indexOfSection(section) {
				throw CollectionView.DataSourceError.existingSection(
					section,
					sectionIndexInSnapshot: index
				)
			}

			snapshot.appendSections([section])
		}

		try append(itemsToTheirSections: sections, to: &snapshot)
	}

	func append(
		itemsToTheirSections sections: [CollectionViewSection],
		to snapshot: inout Snapshot
	) throws {
		for section in sections {
			for item in section.items {
				if let index = snapshot.indexOfItem(item) {
					throw CollectionView.DataSourceError.existingItemInSection(
						item,
						section,
						itemIndexInSnapshot: index
					)
				}

				snapshot.appendItems(
					[item],
					toSection: section
				)
			}
		}
	}

	func imageProviders(for indexPaths: [IndexPath]) -> [ImageProvider] {
		let currentSnapshot = snapshot()
		let supplementaryItemsImageProviders: [ImageProvider] = indexPaths
			.map { $0.section }
			.unique { $0 }
			.sorted()
			.compactMap { currentSnapshot.sectionIdentifiers[safe: $0]?.supplementaryItemsArray }
			.flatMap { $0 }
			.compactMap { $0 as? HasImageProviders }
			.flatMap { $0.imageProviders }

		let itemsImageProviders = indexPaths
			.compactMap { itemIdentifier(for: $0) }
			.compactMap { $0 as? HasImageProviders }
			.flatMap { $0.imageProviders }

		return supplementaryItemsImageProviders + itemsImageProviders
	}
}
