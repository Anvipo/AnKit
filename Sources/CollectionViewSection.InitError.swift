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
		case notUniqueSupplementaryItemsByElementKind(
			supplementaryItemsWithSameElementKind: [CollectionViewSupplementaryItem]
		)

		/// Passed decoration items are not unique by element kind.
		case notUniqueDecorationItemsByElementKind(
			decorationItemsWithSameElementKind: [CollectionViewSupplementaryItem]
		)
	}
}

extension CollectionViewSection.InitError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .itemsAreEmpty:
			return """
			Passed items are empty
			"""

		case let .notUniqueSupplementaryItemsByElementKind(items):
			return """
			Passed supplementary items are not unique by element kind.
			Supplementary items with same element kind: \(items).
			"""

		case let .notUniqueDecorationItemsByElementKind(items):
			return """
			Passed decoration items are not unique by element kind.
			Decoration items with same element kind: \(items).
			"""
		}
	}
}
