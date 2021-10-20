//
//  CollectionViewSection.SetSupplementaryItemsError.swift
//  AnKit
//
//  Created by Anvipo on 20.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `set(supplementaryItems:)` method.
	enum SetSupplementaryItemsError {
		/// Specified supplementary items are not unique by element kind.
		case notUniqueSupplementaryItemsByElementKind(
			supplementaryItemsWithSameElementKind: [CollectionViewSupplementaryItem]
		)
	}
}

extension CollectionViewSection.SetSupplementaryItemsError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .notUniqueSupplementaryItemsByElementKind(items):
			return """
			Specified supplementary items are not unique by element kind.
			Items with same element kind: \(items).
			"""
		}
	}
}
