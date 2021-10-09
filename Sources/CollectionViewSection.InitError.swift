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
		/// Passed supplementary items are not unique by element kind.
		case duplicateSupplementaryElementKind(
			elementKind: String,
			existingItem: CollectionViewSupplementaryItem,
			duplicateItem: CollectionViewSupplementaryItem
		)

		/// Passed items are empty.
		case itemsAreEmpty
	}
}

extension CollectionViewSection.InitError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .itemsAreEmpty:
			return """
			Passed items are empty
			"""

		case let .duplicateSupplementaryElementKind(
			elementKind,
			existingItem,
			duplicateItem
		):
			return """
			Passed supplementary items are not unique by element kind.
			Element kind: \(elementKind).
			Existing item: \(existingItem).
			Duplicate item: \(duplicateItem).
			"""
		}
	}
}
