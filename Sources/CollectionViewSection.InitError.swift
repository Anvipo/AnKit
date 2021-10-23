//
//  CollectionViewSection.InitError.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.09.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` init.
	enum InitError {
		/// Passed items are empty.
		case itemsAreEmpty

		/// Passed supplementary items are not unique by element kind.
		case duplicateItemSupplementaryItemsByElementKind(
			itemSupplementaryItemsWithSameElementKind: [CollectionViewSupplementaryItem]
		)

		/// Passed supplementary items are not unique by element kind.
		case duplicateSupplementaryItemsByElementKind(
			supplementaryItemsWithSameElementKind: [CollectionViewSupplementaryItem]
		)

		/// Passed decoration items are not unique by element kind.
		case duplicateDecorationItemsByElementKind(
			decorationItemsWithSameElementKind: [CollectionViewDecorationItem]
		)

		/// Passed decoration items are not unique by element kind.
		case duplicateElementKind(
			String,
			itemSupplementaryItemElementKinds: Set<String>,
			supplementaryItemElementKinds: Set<String>,
			decorationItemElementKinds: Set<String>
		)
	}
}

extension CollectionViewSection.InitError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .itemsAreEmpty:
			return """
			Specified items are empty
			"""

		case let .duplicateItemSupplementaryItemsByElementKind(items):
			return """
			Specified item's supplementary items are not unique by element kind.
			Item's supplementary items with same element kind: \(items).
			"""

		case let .duplicateSupplementaryItemsByElementKind(items):
			return """
			Specified supplementary items are not unique by element kind.
			Supplementary items with same element kind: \(items).
			"""

		case let .duplicateDecorationItemsByElementKind(items):
			return """
			Specified decoration items are not unique by element kind.
			Decoration items with same element kind: \(items).
			"""

		case let .duplicateElementKind(
			duplicateElementKind,
			itemSupplementaryItemElementKinds,
			supplementaryItemElementKinds,
			decorationItemElementKinds
		):
			return """
			There is duplicate element kind in specified items.
			Duplicate element kind - \(duplicateElementKind).
			Item's supplementary item element kinds - \(itemSupplementaryItemElementKinds).
			Supplementary item element kinds - \(supplementaryItemElementKinds).
			Decoration item element kinds - \(decorationItemElementKinds)
			"""
		}
	}
}
