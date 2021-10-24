//
//  CollectionViewSection.AppendDecorationItemError.swift
//  AnKit
//
//  Created by Anvipo on 21.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `append(decorationItem:)` method.
	enum AppendDecorationItemError {
		/// Specified decoration item is not unique by element kind.
		case duplicateElementKind(
			existingDecorationItemWithSameElementKind: CollectionViewDecorationItem
		)
	}
}

extension CollectionViewSection.AppendDecorationItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .duplicateElementKind(item):
			return """
			Specified decoration item is not unique by element kind.
			Existing decoration item with same element kind: \(item).
			"""
		}
	}
}
