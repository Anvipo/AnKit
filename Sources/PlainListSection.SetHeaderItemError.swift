//
//  PlainListSection.SetHeaderItemError.swift
//  AnKit
//
//  Created by Anvipo on 20.10.2021.
//

import Foundation

public extension PlainListSection {
	/// Error, which could occure, when header item is setting.
	enum SetHeaderItemError {
		/// Passed header item are not unique by element kind.
		case duplicateElementKind(
			elementKind: String,
			existingItem: CollectionViewSupplementaryItem,
			duplicateItem: CollectionViewSupplementaryItem
		)
	}
}

extension PlainListSection.SetHeaderItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .duplicateElementKind(
			elementKind,
			existingItem,
			duplicateItem
		):
			return """
			Passed header item are not unique by element kind.
			Element kind: \(elementKind).
			Existing item: \(existingItem).
			Duplicate item: \(duplicateItem).
			"""
		}
	}
}
