//
//  CollectionViewItem.InitError.swift
//  AnKitPlayground
//
//  Created by Anvipo on 23.10.2021.
//

import Foundation

public extension CollectionViewItem {
	/// Error, which could occure in `CollectionViewItem` init.
	enum InitError {
		/// Specified supplementary items are not unique by element kind.
		case duplicateSupplementaryItemsByElementKind(
			supplementaryItemsWithSameElementKind: [CollectionViewSupplementaryItem]
		)
	}
}

extension CollectionViewItem.InitError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .duplicateSupplementaryItemsByElementKind(items):
			return """
			Specified supplementary items in item are not unique by element kind.
			Supplementary items with same element kind: \(items).
			"""
		}
	}
}
