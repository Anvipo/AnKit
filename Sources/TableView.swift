//
//  TableView.swift
//  AnKit
//
//  Created by Anvipo on 29.11.2021.
//

import UIKit

/// An object that manages an ordered collection of data items and presents them using customizable layouts.
@MainActor
public final class TableView: UITableView {
	private lazy var diffableDataSource = DiffableDataSource(tableView: self)

	override public init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)

		_ = diffableDataSource
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@available(*, unavailable)
	override public func reloadData() {
		super.reloadData()
	}

	@available(*, unavailable)
	override public func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
		super.performBatchUpdates(updates, completion: completion)
	}
}

public extension TableView {
	/// Is collection view data empty.
	var isDataEmpty: Bool {
		diffableDataSource.isDataEmpty
	}

	/// Sections in collection view.
	var sections: [TableViewSection] {
		diffableDataSource.snapshot().sectionIdentifiers
	}

	/// First item in collection view.
	var firstItem: TableViewItem? {
		sections.first?.items.first
	}

	/// Last item in collection view.
	var lastItem: TableViewItem? {
		sections.last?.items.last
	}

	/// Returns an index path for the `item` in the collection view.
	/// - Parameter item: The item in the collection view.
	func indexPath(for item: TableViewItem) -> IndexPath? {
		diffableDataSource.indexPath(for: item)
	}

	/// Returns items in specified `section`.
	/// - Parameter section: Section, which items will be returned.
	/// - Throws: `CollectionView.ItemsInSectionError`.
	func items(in section: TableViewSection) throws -> [TableViewItem] {
		let currentSnapshot = diffableDataSource.snapshot()

		if currentSnapshot.indexOfSection(section) == nil {
			fatalError("TODO")
//			throw ItemsInSectionError.sectionWasNotFound
		}

		return currentSnapshot.itemIdentifiers(inSection: section)
	}
}

// MARK: - set(sections:animatingDifferences:)
public extension TableView {
	/// Sets specified `sections` in collection view.
	/// - Parameters:
	///   - sections: Sections, which will be set in collection view.
	///   - animatingDifferences: Should set be animated.
	///   - completion: A closure to be executed when the animations are complete.
	/// - Throws: `CollectionView.DataSourceError`.
	func set(
		sections: [TableViewSection],
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
		sections: [TableViewSection],
		animatingDifferences: Bool
	) async throws {
		registerItems(in: sections)

		try await diffableDataSource.set(
			sections: sections,
			animatingDifferences: animatingDifferences
		)
	}
}

private extension TableView {
	func registerItems(in sections: [TableViewSection]) {
		if sections.isEmpty {
			return
		}

		for section in sections {
			register(items: section.items)
		}
	}

	func register(items: [TableViewItem]) {
		if items.isEmpty {
			return
		}

		let uniqueItemsByReuseIdentifier = items.unique { $0.cellType.reuseIdentifier }

		for item in uniqueItemsByReuseIdentifier {
			let cellType = item.cellType

			register(
				cellType,
				forCellReuseIdentifier: cellType.reuseIdentifier
			)
		}
	}
}
