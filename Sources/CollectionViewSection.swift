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
	public final var visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?

	/// Items in section
	///
	/// This property always is not empty.
	public private(set) final var items: [CollectionViewItem] {
		willSet {
			if newValue.isEmpty {
				fatalError("Items must not be empty")
			}
		}
	}

	/// Supplementary items in section.
	///
	/// Could be empty.
	public final var supplementaryItems: [String: CollectionViewSupplementaryItem]

	/// Decoration items in section.
	///
	/// Could be empty.
	public final let decorationItems: [String: CollectionViewDecorationItem]

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
	/// - Throws: `CollectionViewSection.InitError`.
	public init(
		items: [CollectionViewItem],
		supplementaryItems: [String: CollectionViewSupplementaryItem] = [:],
		decorationItems: [String: CollectionViewDecorationItem] = [:],
		contentInsets: NSDirectionalEdgeInsets = .zero,
		visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler? = nil,
		id: ID = ID()
	) throws {
		if items.isEmpty {
			throw InitError.itemsAreEmpty
		}

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
}

public extension CollectionViewSection {
	/// Sets specified items.
	/// - Parameter items: Items, which will be set.
	/// - Throws: `CollectionViewSection.SetItemsError`.
	func set(items: [CollectionViewItem]) throws {
		if items.isEmpty {
			throw SetItemsError.itemsAreEmpty
		}

		self.items = items
	}

	/// Calculates height, which section will fill.
	/// - Parameter availableWidth: Available width for section.
	func contentHeight(availableWidth: CGFloat) throws -> CGFloat {
		let result = try items
			.map { try $0.cellHeight(availableWidth: availableWidth) }
			.sum

		if !result.isNormal {
			throw ContentHeightCalculateError.isNotNormal(
				section: self,
				calculatedHeight: result,
				availableWidth: availableWidth
			)
		}

		if result < .zero {
			throw ContentHeightCalculateError.isLessThanZero(
				section: self,
				calculatedHeight: result,
				availableWidth: availableWidth
			)
		}

		return result
	}

	/// Calculates average height, which items will fill.
	/// - Parameter availableWidth: Available width for section.
	func contentAverageHeight(availableWidth: CGFloat) throws -> CGFloat {
		let cellHeights = try contentHeight(availableWidth: availableWidth)

		return cellHeights / CGFloat(items.count)
	}

	/// Clears all cached heights.
	func clearCachedHeights() {
		for item in items {
			item.clearCachedCellHeights()
		}

		for supplementaryItem in supplementaryItems.values {
			supplementaryItem.clearCachedSupplementaryViewHeights()
		}

		for decorationItem in decorationItems.values {
			decorationItem.clearCachedSupplementaryViewHeights()
		}
	}

	/// Calculates width, which section will fill.
	/// - Parameter availableHeight: Available height for section.
	func contentWidth(availableHeight: CGFloat) throws -> CGFloat {
		let result = try items
			.map { try $0.cellWidth(availableHeight: availableHeight) }
			.sum

		if !result.isNormal {
			throw ContentWidthCalculateError.isNotNormal(
				section: self,
				calculatedWidth: result,
				availableHeight: availableHeight
			)
		}

		if result < .zero {
			throw ContentWidthCalculateError.isLessThanZero(
				section: self,
				calculatedWidth: result,
				availableHeight: availableHeight
			)
		}

		return result
	}

	/// Calculates average width, which items will fill.
	/// - Parameter availableWidth: Available height for section.
	func contentAverageWidth(availableHeight: CGFloat) throws -> CGFloat {
		let cellWidths = try contentWidth(availableHeight: availableHeight)

		return cellWidths / CGFloat(items.count)
	}

	/// Clears all cached heights.
	func clearCachedWidths() {
		for item in items {
			item.clearCachedCellWidths()
		}

		for supplementaryItem in supplementaryItems.values {
			supplementaryItem.clearCachedSupplementaryViewWidths()
		}

		for decorationItem in decorationItems.values {
			decorationItem.clearCachedSupplementaryViewWidths()
		}
	}
}

extension CollectionViewSection: Equatable {
	public static func == (
		lhs: CollectionViewSection,
		rhs: CollectionViewSection
	) -> Bool {
		lhs.items == rhs.items &&
		lhs.supplementaryItems == rhs.supplementaryItems &&
		lhs.contentInsets == rhs.contentInsets &&
		lhs.id == rhs.id
	}
}

extension CollectionViewSection: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(items)
		hasher.combine(supplementaryItems)
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
		for supplementaryItem in supplementaryItemsArray {
			if var shimmerableSupplementaryItem = supplementaryItem as? Shimmerable {
				shimmerableSupplementaryItem.isShimmering = true
			}
		}

		for item in items {
			guard var shimmerableItem = item as? Shimmerable else {
				continue
			}

			shimmerableItem.isShimmering = true
		}
	}

	/// Has section same content as passed `other`.
	/// - Parameter other: Other section, which will be used in compare.
	func hasSameContent(as other: CollectionViewSection) -> Bool {
		supplementaryItemsArray.map { $0.typeErasedContent } == other.supplementaryItemsArray.map { $0.typeErasedContent } &&
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
}

extension CollectionViewSection {
	var supplementaryItemsArray: [CollectionViewSupplementaryItem] {
		Array(supplementaryItems.values)
	}

	func supplementaryItem(for kind: String) -> CollectionViewSupplementaryItem? {
		supplementaryItems[kind]
	}
}
