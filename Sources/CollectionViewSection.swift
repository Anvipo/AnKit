//
//  CollectionViewSection.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//
// swiftlint:disable unavailable_function

import UIKit

/// Abstract section for collection view.
open class CollectionViewSection {
	/// The amount of space between the content of the section and its boundaries.
	public final var contentInsets: NSDirectionalEdgeInsets

	/// A closure called before each layout cycle to allow modification of the items in the section immediately before they are displayed.
	open var visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?

	/// Items in section
	///
	/// This property always is not empty.
	open private(set) var items: [CollectionViewItem]

	/// Supplementary items in section.
	///
	/// Could be empty.
	open private(set) var supplementaryItems: [CollectionViewSupplementaryItem]

	/// Decoration items in section.
	///
	/// Could be empty.
	open private(set) var decorationItems: [CollectionViewDecorationItem]

	// swiftlint:disable:next missing_docs
	public final let id: ID

	/// Initializes section with specified parameters.
	/// - Parameters:
	///   - items: Items in section. Must not be empty.
	///   - supplementaryItems: Supplementary items in section. Could be empty.
	///   - decorationItems: Decoration items in section.
	///   - contentInsets: The amount of space between the content of the section and its boundaries.
	///   - visibleItemsInvalidationHandler: A closure called before each layout cycle to allow modification of the items
	///   in the section immediately before they are displayed.
	///   - id: The stable identity of the entity associated with this instance.
	///
	/// - Throws: `CollectionViewSection.InitError`.
	public init(
		items: [CollectionViewItem],
		supplementaryItems: [CollectionViewSupplementaryItem] = [],
		decorationItems: [CollectionViewDecorationItem] = [],
		contentInsets: NSDirectionalEdgeInsets = .zero,
		visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler? = nil,
		id: ID = ID()
	) throws {
		if items.isEmpty {
			throw InitError.itemsAreEmpty
		}

		try Self.checkElementKinds(
			items: items,
			supplementaryItems: supplementaryItems,
			decorationItems: decorationItems
		)

		self.items = items
		self.supplementaryItems = supplementaryItems
		self.decorationItems = decorationItems
		self.contentInsets = contentInsets
		self.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler
		self.id = id
	}

	/// Creates layout configuration of this section.
	/// - Parameter layoutEnvironment: Information about the current layout environment.
	open func layoutConfiguration(
		layoutEnvironment: NSCollectionLayoutEnvironment
	) -> NSCollectionLayoutSection {
		fatalError("Implement this method in your class")
	}

	// MARK: items methods

	/// Sets specified items.
	/// - Parameter items: Items, which will be set.
	/// - Throws: `CollectionViewSection.SetItemsError`.
	open func set(items: [CollectionViewItem]) throws {
		if items.isEmpty {
			throw SetItemsError.itemsAreEmpty
		}

		self.items = items
	}

	/// Removes specified item.
	/// - Parameter item: Item, which will be removed.
	/// - Throws: `CollectionViewSection.RemoveItemError`.
	open func remove(item: CollectionViewItem) throws {
		guard let index = items.firstIndex(of: item) else {
			throw RemoveItemError.noItem
		}

		items.remove(at: index)
	}

	/// Appends specified item.
	/// - Parameter item: Item, which will be removed.
	/// - Throws: `CollectionViewSection.AppendItemError`.
	open func append(item: CollectionViewItem) throws {
		if let existingItem = items.first(where: { $0 == item }) {
			throw AppendItemError.duplicateItem(existingSameItem: existingItem)
		}

		items.append(item)
	}

	// MARK: supplementary items methods

	/// Sets specified supplementary items.
	/// - Parameter supplementaryItems: Supplementary items, which will be set.
	/// - Throws: `CollectionViewSection.SetSupplementaryItemsError`.
	open func set(supplementaryItems: [CollectionViewSupplementaryItem]) throws {
		for (_, groupedSupplementaryItems) in Dictionary(grouping: supplementaryItems, by: { $0.elementKind }) {
			if groupedSupplementaryItems.count > 1 {
				throw SetSupplementaryItemsError.notUniqueSupplementaryItemsByElementKind(
					supplementaryItemsWithSameElementKind: groupedSupplementaryItems
				)
			}
		}

		self.supplementaryItems = supplementaryItems
	}

	/// Removes specified supplementary item.
	/// - Parameter supplementaryItem: Supplementary item, which will be removed.
	/// - Throws: `CollectionViewSection.RemoveSupplementaryItemError`.
	open func remove(supplementaryItem: CollectionViewSupplementaryItem) throws {
		guard let index = supplementaryItems.firstIndex(of: supplementaryItem) else {
			throw RemoveSupplementaryItemError.noSupplementaryItem
		}

		supplementaryItems.remove(at: index)
	}

	/// Appends specified supplementary item.
	/// - Parameter supplementaryItem: Supplementary item, which will be removed.
	/// - Throws: `CollectionViewSection.AppendSupplementaryItemError`.
	open func append(supplementaryItem: CollectionViewSupplementaryItem) throws {
		if let existingItem = supplementaryItems.first(where: { $0.elementKind == supplementaryItem.elementKind }) {
			throw AppendSupplementaryItemError.notUniqueElementKind(
				existingSupplementaryItemWithSameElementKind: existingItem
			)
		}

		supplementaryItems.append(supplementaryItem)
	}

	/// Sets specified decoration items.
	/// - Parameter decorationItems: Decoration items, which will be set.
	/// - Throws: `CollectionViewSection.SetDecorationItemsError`.
	open func set(decorationItems: [CollectionViewDecorationItem]) throws {
		for (_, groupedDecorationItems) in Dictionary(grouping: decorationItems, by: { $0.elementKind }) {
			if groupedDecorationItems.count > 1 {
				throw SetDecorationItemsError.duplicateDecorationItemsByElementKind(
					decorationItemsWithSameElementKind: groupedDecorationItems
				)
			}
		}

		self.decorationItems = decorationItems
	}

	/// Removes specified decoration item.
	/// - Parameter decorationItem: Decoration item, which will be removed.
	/// - Throws: `CollectionViewSection.RemoveDecorationItemError`.
	open func remove(decorationItem: CollectionViewDecorationItem) throws {
		guard let index = decorationItems.firstIndex(of: decorationItem) else {
			throw RemoveDecorationItemError.noDecorationItem
		}

		decorationItems.remove(at: index)
	}

	/// Appends specified decoration item.
	/// - Parameter decorationItem: Decoration item, which will be removed.
	/// - Throws: `CollectionViewSection.AppendDecorationItemError`.
	open func append(decorationItem: CollectionViewDecorationItem) throws {
		if let existingItem = decorationItems.first(where: { $0.elementKind == decorationItem.elementKind }) {
			throw AppendDecorationItemError.duplicateElementKind(
				existingDecorationItemWithSameElementKind: existingItem
			)
		}

		decorationItems.append(decorationItem)
	}
}

public extension CollectionViewSection {
	/// Invalidates all cached heights.
	func invalidateCachedHeights() {
		for item in items {
			item.invalidateCachedCellHeights()
		}

		for supplementaryItem in supplementaryItems {
			supplementaryItem.invalidateCachedSupplementaryViewHeights()
		}
	}

	/// Invalidates all cached heights.
	func invalidateCachedWidths() {
		for item in items {
			item.invalidateCachedCellWidths()
		}

		for supplementaryItem in supplementaryItems {
			supplementaryItem.invalidateCachedSupplementaryViewWidths()
		}
	}

	/// The absolute width of the section content after content insets are applied.
	/// - Parameter layoutEnvironment: Information about the layout's container and environment traits,
	/// such as size classes and display scale factor.
	func effectiveContentWidthLayoutDimension(
		layoutEnvironment: NSCollectionLayoutEnvironment
	) -> NSCollectionLayoutDimension {
		.absolute(effectiveContentWidth(layoutEnvironment: layoutEnvironment))
	}

	/// The width of the section content after content insets are applied.
	/// - Parameter layoutEnvironment: Information about the layout's container and environment traits,
	/// such as size classes and display scale factor.
	func effectiveContentWidth(
		layoutEnvironment: NSCollectionLayoutEnvironment
	) -> CGFloat {
		layoutEnvironment.container.effectiveContentSize.width
		- contentInsets.leading
		- contentInsets.trailing
	}
}

extension CollectionViewSection: Equatable {
	public static func == (
		lhs: CollectionViewSection,
		rhs: CollectionViewSection
	) -> Bool {
		lhs.items == rhs.items &&
		lhs.supplementaryItems == rhs.supplementaryItems &&
		lhs.decorationItems == rhs.decorationItems &&
		lhs.contentInsets == rhs.contentInsets &&
		lhs.id == rhs.id
	}
}

extension CollectionViewSection: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(items)
		hasher.combine(supplementaryItems)
		hasher.combine(decorationItems)
		hasher.combine(contentInsets)
		hasher.combine(id)
	}
}

extension CollectionViewSection: Identifiable {
	public typealias ID = UUID
}

public extension CollectionViewSection {
	/// Set `isShimmering` property to true in items.
	func shimmerItems() {
		for supplementaryItem in supplementaryItems {
			guard var shimmerableSupplementaryItem = supplementaryItem as? Shimmerable else {
				continue
			}

			shimmerableSupplementaryItem.isShimmering = true
		}

		for item in items {
			guard var shimmerableItem = item as? Shimmerable else {
				continue
			}

			shimmerableItem.isShimmering = true
		}

		for decorationItem in decorationItems {
			guard var shimmerableDecorationItem = decorationItem as? Shimmerable else {
				continue
			}

			shimmerableDecorationItem.isShimmering = true
		}
	}

	/// Has section same content as passed `other`.
	/// - Parameter other: Other section, which will be used in compare.
	func hasSameContent(as other: CollectionViewSection) -> Bool {
		supplementaryItems.map { $0.typeErasedContent } == other.supplementaryItems.map { $0.typeErasedContent } &&
		decorationItems.map { $0.typeErasedContent } == other.decorationItems.map { $0.typeErasedContent } &&
		items.hasSameContent(as: other.items)
	}
}

public extension Array where Element: CollectionViewSection {
	/// Has section same content as passed `other`.
	/// - Parameter other: Other section, which will be used in compare.
	func hasSameContent(as other: [CollectionViewSection]) -> Bool {
		guard count == other.count else {
			return false
		}

		for index in self.indices {
			if !self[index].hasSameContent(as: other[index]) {
				return false
			}
		}

		return true
	}

	/// Set `isShimmering` property to true in sections items.
	func shimmerItems() {
		for section in self {
			section.shimmerItems()
		}
	}

	/// Invalidates all cached heights.
	func invalidateCachedHeights() {
		for section in self {
			section.invalidateCachedHeights()
		}
	}

	/// Invalidates all cached widths.
	func invalidateCachedWidths() {
		for section in self {
			section.invalidateCachedWidths()
		}
	}
}

extension CollectionViewSection {
	func supplementaryItem(for kind: String) -> CollectionViewSupplementaryItem? {
		supplementaryItems.first { $0.elementKind == kind } ?? items.supplementaryItem(for: kind)
	}
}

private extension CollectionViewSection {
	// swiftlint:disable:next cyclomatic_complexity
	static func checkElementKinds(
		items: [CollectionViewItem],
		supplementaryItems: [CollectionViewSupplementaryItem],
		decorationItems: [CollectionViewDecorationItem]
	) throws {
		let groupedItemSupplementaryItems = Dictionary(grouping: items.flatMap { $0.supplementaryItems }) { $0.elementKind }
		for itemSupplementaryItems in groupedItemSupplementaryItems.values {
			if itemSupplementaryItems.count > 1 {
				throw InitError.duplicateItemSupplementaryItemsByElementKind(
					itemSupplementaryItemsWithSameElementKind: itemSupplementaryItems
				)
			}
		}

		let groupedSupplementaryItems = Dictionary(grouping: supplementaryItems) { $0.elementKind }
		for supplementaryItems in groupedSupplementaryItems.values {
			if supplementaryItems.count > 1 {
				throw InitError.duplicateSupplementaryItemsByElementKind(
					supplementaryItemsWithSameElementKind: supplementaryItems
				)
			}
		}

		let groupedDecorationItems = Dictionary(grouping: decorationItems) { $0.elementKind }
		for decorationItems in groupedDecorationItems.values {
			if decorationItems.count > 1 {
				throw InitError.duplicateDecorationItemsByElementKind(
					decorationItemsWithSameElementKind: decorationItems
				)
			}
		}

		if !groupedSupplementaryItems.isEmpty || !groupedDecorationItems.isEmpty {
			let supplementaryItemElementKinds = Set(groupedSupplementaryItems.keys)
			let decorationItemElementKinds = Set(groupedDecorationItems.keys)
			let itemSupplementaryItemElementKinds = Set(groupedItemSupplementaryItems.keys)

			var sectionElementKinds = supplementaryItemElementKinds

			for decorationItemElementKind in decorationItemElementKinds {
				if !sectionElementKinds.insert(decorationItemElementKind).inserted {
					throw InitError.duplicateElementKind(
						decorationItemElementKind,
						itemSupplementaryItemElementKinds: itemSupplementaryItemElementKinds,
						supplementaryItemElementKinds: supplementaryItemElementKinds,
						decorationItemElementKinds: decorationItemElementKinds
					)
				}
			}

			for itemSupplementaryItemElementKind in itemSupplementaryItemElementKinds {
				if !sectionElementKinds.insert(itemSupplementaryItemElementKind).inserted {
					throw InitError.duplicateElementKind(
						itemSupplementaryItemElementKind,
						itemSupplementaryItemElementKinds: itemSupplementaryItemElementKinds,
						supplementaryItemElementKinds: supplementaryItemElementKinds,
						decorationItemElementKinds: decorationItemElementKinds
					)
				}
			}
		}
	}
}
