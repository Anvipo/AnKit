//
//  CollectionViewSection.AppendSupplementaryItemError.swift
//  AnKit
//
//  Created by Anvipo on 20.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `append(supplementaryItem:)` method.
	enum AppendSupplementaryItemError {
		/// Specified supplementary item is not unique by element kind.
		case notUniqueElementKind(
			existingSupplementaryItemWithSameElementKind: CollectionViewSupplementaryItem
		)
	}
}

extension CollectionViewSection.AppendSupplementaryItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .notUniqueElementKind(item):
			return """
			Specified supplementary item is not unique by element kind.
			Existing supplementary item with same element kind: \(item).
			"""
		}
	}
}
