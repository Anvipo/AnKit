//
//  TableViewSection.swift
//  AnKit
//
//  Created by Anvipo on 29.11.2021.
//

import UIKit

/// Abstract section for collection view.
open class TableViewSection {
	/// Items in section
	///
	/// This property always is not empty.
	open private(set) var items: [TableViewItem]

	// swiftlint:disable:next missing_docs
	public final let id: ID

	/// Initializes section with specified parameters.
	/// - Parameters:
	///   - items: Items in section. Must not be empty.
	///   - id: The stable identity of the entity associated with this instance.
	///
	/// - Throws: `TableViewSection.InitError`.
	public init(
		items: [TableViewItem],
		id: ID = ID()
	) throws {
		if items.isEmpty {
			fatalError("TODO")
//			throw InitError.itemsAreEmpty
		}

		self.items = items
		self.id = id
	}

	// MARK: items methods

	/// Sets specified items.
	/// - Parameter items: Items, which will be set.
	/// - Throws: `CollectionViewSection.SetItemsError`.
	open func set(items: [TableViewItem]) throws {
		if items.isEmpty {
			fatalError("TODO")
//			throw SetItemsError.itemsAreEmpty
		}

		self.items = items
	}

	/// Removes specified item.
	/// - Parameter item: Item, which will be removed.
	/// - Throws: `CollectionViewSection.RemoveItemError`.
	open func remove(item: TableViewItem) throws {
		guard let index = items.firstIndex(of: item) else {
//			throw RemoveItemError.noItem
			fatalError("TODO")
		}

		items.remove(at: index)
	}

	/// Appends specified item.
	/// - Parameter item: Item, which will be removed.
	/// - Throws: `CollectionViewSection.AppendItemError`.
	open func append(item: TableViewItem) throws {
		if let existingItem = items.first(where: { $0 == item }) {
			fatalError("TODO")
//			throw AppendItemError.duplicateItem(existingSameItem: existingItem)
		}

		items.append(item)
	}

	// swiftlint:disable:next missing_docs
	open func hash(into hasher: inout Hasher) {
		hasher.combine(items)
		hasher.combine(id)
	}
}

extension TableViewSection: Equatable {
	public static func == (
		lhs: TableViewSection,
		rhs: TableViewSection
	) -> Bool {
		lhs.items == rhs.items &&
		lhs.id == rhs.id
	}
}

extension TableViewSection: Hashable {}

extension TableViewSection: Identifiable {
	public typealias ID = UUID
}
