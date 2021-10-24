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
		/// Specified items are empty.
		case itemsAreEmpty

		/// Specified supplementary items are not unique by element kind.
		case duplicateItemSupplementaryItemsByElementKind([CollectionViewSupplementaryItem])

		/// Specified boundary supplementary items are not unique by element kind.
		case duplicateBoundarySupplementaryItemsByElementKind([CollectionViewBoundarySupplementaryItem])

		/// Specified decoration items are not unique by element kind.
		case duplicateDecorationItemsByElementKind([CollectionViewDecorationItem])

		/// Specified decoration items are not unique by element kind.
		case duplicateElementKind(
			String,
			itemSupplementaryItemElementKinds: Set<String>,
			boundarySupplementaryItemElementKinds: Set<String>,
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

		case let .duplicateBoundarySupplementaryItemsByElementKind(items):
			return """
			Specified boundary supplementary items are not unique by element kind.
			Boundary supplementary items with same element kind: \(items).
			"""

		case let .duplicateDecorationItemsByElementKind(items):
			return """
			Specified decoration items are not unique by element kind.
			Decoration items with same element kind: \(items).
			"""

		case let .duplicateElementKind(
			duplicateElementKind,
			itemSupplementaryItemElementKinds,
			boundarySupplementaryItemElementKinds,
			decorationItemElementKinds
		):
			return """
			There is duplicate element kind in specified items.
			Duplicate element kind - \(duplicateElementKind).
			Item's supplementary item element kinds - \(itemSupplementaryItemElementKinds).
			Boundary supplementary item element kinds - \(boundarySupplementaryItemElementKinds).
			Decoration item element kinds - \(decorationItemElementKinds)
			"""
		}
	}
}
