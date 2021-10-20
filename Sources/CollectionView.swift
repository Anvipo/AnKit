//
//  CollectionView.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// An object that manages an ordered collection of data items and presents them using customizable layouts.
@MainActor
public final class CollectionView: UICollectionView {
	private lazy var diffableDataSource = DiffableDataSource(collectionView: self)
	private lazy var layout = CompositionalLayout(collectionView: self)

	@available(*, unavailable)
	override public var collectionViewLayout: UICollectionViewLayout {
		get {
			compositionalLayout
		}
		set {
			// swiftlint:disable:previous unused_setter_value
			fatalError("Do not use this method")
		}
	}

	/// Initializes a collection view.
	@MainActor
	public init() {
		super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())

		super.collectionViewLayout = compositionalLayout
		// initializing for "thread-safety"
		_ = diffableDataSource
		backgroundColor = .clear
	}

	@available(*, unavailable)
	override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		fatalError("init(frame:collectionViewLayout:) has not been implemented")
	}

	@available(*, unavailable)
	public init(frame: CGRect) {
		fatalError("init(frame:) has not been implemented")
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@available(*, unavailable)
	override public func setCollectionViewLayout(
		_ layout: UICollectionViewLayout,
		animated: Bool
	) {
		fatalError("Do not use this method")
	}

	@available(*, unavailable)
	override public func setCollectionViewLayout(
		_ layout: UICollectionViewLayout,
		animated: Bool,
		completion: ((Bool) -> Void)? = nil
	) {
		fatalError("Do not use this method")
	}

	@available(*, unavailable)
	override public func reloadData() {
		super.reloadData()
	}

	@available(*, unavailable)
	override public func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
		super.performBatchUpdates(updates, completion: completion)
	}

	@available(*, unavailable)
	override public func insertSections(_ sections: IndexSet) {
		super.insertSections(sections)
	}

	@available(*, unavailable)
	override public func deleteSections(_ sections: IndexSet) {
		super.deleteSections(sections)
	}

	@available(*, unavailable)
	override public func moveSection(_ section: Int, toSection newSection: Int) {
		super.moveSection(section, toSection: newSection)
	}

	@available(*, unavailable)
	override public func reloadSections(_ sections: IndexSet) {
		super.reloadSections(sections)
	}

	@available(*, unavailable)
	override public func insertItems(at indexPaths: [IndexPath]) {
		super.insertItems(at: indexPaths)
	}

	@available(*, unavailable)
	override public func deleteItems(at indexPaths: [IndexPath]) {
		super.deleteItems(at: indexPaths)
	}

	@available(*, unavailable)
	override public func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
		super.moveItem(at: indexPath, to: newIndexPath)
	}

	@available(*, unavailable)
	override public func reloadItems(at indexPaths: [IndexPath]) {
		super.reloadItems(at: indexPaths)
	}

	@available(*, unavailable)
	override public func reconfigureItems(at indexPaths: [IndexPath]) {
		if #available(iOS 15.0, *) {
			super.reconfigureItems(at: indexPaths)
		}
	}
}

public extension CollectionView {
	/// Array of `SnapshotAction`s.
	typealias SnapshotTransaction = [SnapshotAction]

	/// Is collection view data empty.
	var isDataEmpty: Bool {
		diffableDataSource.isDataEmpty
	}

	/// Sections in collection view.
	var sections: [CollectionViewSection] {
		diffableDataSource.snapshot().sectionIdentifiers
	}

	/// First item in collection view.
	var firstItem: CollectionViewItem? {
		sections.first?.items.first
	}

	/// Last item in collection view.
	var lastItem: CollectionViewItem? {
		sections.last?.items.last
	}

	/// The object that acts as the scroll view delegate of the collection view.
	var scrollViewDelegate: UIScrollViewDelegate? {
		get {
			diffableDataSource.scrollViewDelegate
		}
		set {
			diffableDataSource.scrollViewDelegate = newValue
		}
	}

	/// The object that acts as the prefetching data source for the collection view,
	/// receiving notifications of upcoming cell data requirements.
	var prefetchingDelegate: CollectionViewPrefetchingDelegate? {
		get {
			diffableDataSource.prefetchingDelegate
		}
		set {
			diffableDataSource.prefetchingDelegate = newValue
		}
	}

	/// The layout used to organize the collected view’s items.
	var compositionalLayout: UICollectionViewCompositionalLayout {
		layout
	}

	/// Returns an index path for the `item` in the collection view.
	/// - Parameter item: The item in the collection view.
	func indexPath(for item: CollectionViewItem) -> IndexPath? {
		diffableDataSource.indexPath(for: item)
	}
}

// MARK: - set(sections:animatingDifferences:)
public extension CollectionView {
	/// Sets specified `sections` in collection view.
	/// - Parameters:
	///   - sections: Sections, which will be set in collection view.
	///   - animatingDifferences: Should set be animated.
	///   - completion: A closure to be executed when the animations are complete.
	/// - Throws: `CollectionView.DataSourceError`.
	func set(
		sections: [CollectionViewSection],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		registerItems(in: sections)

		try diffableDataSource.set(
			sections: sections,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	/// Sets specified `sections` in collection view.
	/// - Parameters:
	///   - sections: Sections, which will be set in collection view.
	///   - animatingDifferences: Should set be animated.
	/// - Throws: `CollectionView.DataSourceError`.
	@available(iOS 15, *)
	func set(
		sections: [CollectionViewSection],
		animatingDifferences: Bool
	) async throws {
		registerItems(in: sections)

		try await diffableDataSource.set(
			sections: sections,
			animatingDifferences: animatingDifferences
		)
	}
}

// MARK: - reload(items:animatingDifferences:)
public extension CollectionView {
	/// Reloads specified `items` in collection view.
	/// - Parameters:
	///   - items: Items, which will be reloaded.
	///   - animatingDifferences: Should reload be animated.
	///   - completion: A closure to be executed when the animations are complete.
	/// - Throws: `CollectionView.DataSourceError`.
	func reload(
		items: [CollectionViewItem],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		try diffableDataSource.reload(
			items: items,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	/// Reloads specified `items` in collection view.
	/// - Parameters:
	///   - items: Items, which will be reloaded.
	///   - animatingDifferences: Should reload be animated.
	/// - Throws: `CollectionView.DataSourceError`.
	@available(iOS 15, *)
	func reload(
		items: [CollectionViewItem],
		animatingDifferences: Bool
	) async throws {
		try await diffableDataSource.reload(
			items: items,
			animatingDifferences: animatingDifferences
		)
	}
}

// MARK: - reconfigure(items:animatingDifferences:)
public extension CollectionView {
	/// Reconfigures specified `items` in collection view.
	/// - Parameters:
	///   - items: Items, which will be reloaded.
	///   - animatingDifferences: Should reconfigure be animated.
	/// - Throws: `CollectionView.DataSourceError`.
	@available(iOS 15, *)
	func reconfigure(
		items: [CollectionViewItem],
		animatingDifferences: Bool
	) async throws {
		try await diffableDataSource.reconfigure(
			items: items,
			animatingDifferences: animatingDifferences
		)
	}

	/// Reconfigures specified `items` in collection view, if device iOS version is greater or equal to 15.
	/// In other way, reloads specified `items`.
	/// - Parameters:
	///   - items: Items, which will be reloaded.
	///   - animatingDifferences: Should reconfigure be animated.
	///   - completion: A closure to be executed when the animations are complete.
	/// - Throws: `CollectionView.DataSourceError`.
	func reconfigureOrReload(
		items: [CollectionViewItem],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		if #available(iOS 15.0, *) {
			try diffableDataSource.reconfigure(
				items: items,
				animatingDifferences: animatingDifferences,
				completion: completion
			)
		} else {
			try diffableDataSource.reload(
				items: items,
				animatingDifferences: animatingDifferences,
				completion: completion
			)
		}
	}
}

// MARK: - reload(sections:animatingDifferences:)
public extension CollectionView {
	/// Reloads specified `sections` in collection view.
	/// - Parameters:
	///   - sections: Sections, which will be reloaded.
	///   - animatingDifferences: Should reload be animated.
	///   - completion: A closure to be executed when the animations are complete.
	/// - Throws: `CollectionView.DataSourceError`.
	func reload(
		sections: [CollectionViewSection],
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		try diffableDataSource.reload(
			sections: sections,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	/// Reloads specified `sections` in collection view.
	/// - Parameters:
	///   - sections: Sections, which will be reloaded.
	///   - animatingDifferences: Should reload be animated.
	/// - Throws: `CollectionView.DataSourceError`.
	@available(iOS 15, *)
	func reload(
		sections: [CollectionViewSection],
		animatingDifferences: Bool
	) async throws {
		try await diffableDataSource.reload(
			sections: sections,
			animatingDifferences: animatingDifferences
		)
	}
}

// MARK: - apply(snapshotTransaction:animatingDifferences:)
public extension CollectionView {
	/// Applies specified `snapshotTransaction`.
	/// - Parameters:
	///   - snapshotTransaction: Snapshot transaction, which will be applied.
	///   - animatingDifferences: Should apply be animated.
	///   - completion: A closure to be executed when the animations are complete.
	/// - Throws: `CollectionView.DataSourceError`.
	func apply(
		snapshotTransaction: SnapshotTransaction,
		animatingDifferences: Bool,
		completion: (() -> Void)? = nil
	) throws {
		for snapshotAction in snapshotTransaction {
			switch snapshotAction {
			case .deleteSections,
				 .deleteItems,
				 .reloadItems,
				 .reloadSections,
				 .reconfigureItems,
				 .reconfigureOrReloadItems:
				break

			case let .appendSections(sections),
				 let .setSections(sections):
				registerItems(in: sections)

			case let .appendItems(items, _),
				 let .insertItemsAfterItem(items, _):
				register(items: items)

			case let .insertSectionsAfterSection(sections, _):
				registerItems(in: sections)
			}
		}

		try diffableDataSource.apply(
			snapshotTransaction: snapshotTransaction,
			animatingDifferences: animatingDifferences,
			completion: completion
		)
	}

	/// Applies specified `snapshotTransaction`.
	/// - Parameters:
	///   - snapshotTransaction: Snapshot transaction, which will be applied.
	///   - animatingDifferences: Should apply be animated.
	/// - Throws: `CollectionView.DataSourceError`.
	@available(iOS 15, *)
	func apply(
		snapshotTransaction: SnapshotTransaction,
		animatingDifferences: Bool
	) async throws {
		for snapshotAction in snapshotTransaction {
			switch snapshotAction {
			case .deleteSections,
				 .deleteItems,
				 .reloadItems,
				 .reloadSections,
				 .reconfigureItems,
				 .reconfigureOrReloadItems:
				break

			case let .appendSections(sections),
				 let .setSections(sections):
				registerItems(in: sections)

			case let .appendItems(items, _),
				 let .insertItemsAfterItem(items, _):
				register(items: items)

			case let .insertSectionsAfterSection(sections, _):
				registerItems(in: sections)
			}
		}

		try await diffableDataSource.apply(
			snapshotTransaction: snapshotTransaction,
			animatingDifferences: animatingDifferences
		)
	}
}

private extension CollectionView {
	func registerItems(in sections: [CollectionViewSection]) {
		if sections.isEmpty {
			return
		}

		for section in sections {
			for supplementaryItem in section.supplementaryItems {
				let supplementaryViewType = supplementaryItem.supplementaryViewType

				register(
					supplementaryViewType,
					forSupplementaryViewOfKind: supplementaryItem.elementKind,
					withReuseIdentifier: supplementaryViewType.reuseIdentifier
				)
			}

			for decorationItem in section.decorationItems {
				let supplementaryViewType = decorationItem.supplementaryViewType

				compositionalLayout.register(
					supplementaryViewType,
					forDecorationViewOfKind: decorationItem.elementKind
				)
			}

			register(items: section.items)
		}
	}

	func register(items: [CollectionViewItem]) {
		if items.isEmpty {
			return
		}

		let uniqueItemsByReuseIdentifier = items.unique { $0.cellType.reuseIdentifier }

		for item in uniqueItemsByReuseIdentifier {
			let cellType = item.cellType

			register(
				cellType,
				forCellWithReuseIdentifier: cellType.reuseIdentifier
			)
		}
	}
}
