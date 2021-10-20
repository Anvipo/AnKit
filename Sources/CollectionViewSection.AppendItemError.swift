//
//  CollectionViewSection.AppendItemError.swift
//  AnKit
//
//  Created by Anvipo on 21.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `append(item:)` method.
	enum AppendItemError {
		/// Specified item is not unique by element kind.
		case duplicateItem(existingSameItem: CollectionViewItem)
	}
}

extension CollectionViewSection.AppendItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .duplicateItem(existingSameItem):
			return """
			Passed item is not unique.
			Existing same item: \(existingSameItem).
			"""
		}
	}
}
