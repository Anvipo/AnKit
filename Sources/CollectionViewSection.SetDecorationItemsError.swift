//
//  CollectionViewSection.SetDecorationItemsError.swift
//  AnKit
//
//  Created by Anvipo on 21.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `set(decorationItems:)` method.
	enum SetDecorationItemsError {
		/// Specified decoration items are not unique by element kind.
		case duplicateDecorationItemsByElementKind(
			decorationItemsWithSameElementKind: [CollectionViewDecorationItem]
		)
	}
}

extension CollectionViewSection.SetDecorationItemsError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .duplicateDecorationItemsByElementKind(items):
			return """
			Specified decoration items are not unique by element kind.
			Items with same element kind: \(items).
			"""
		}
	}
}
