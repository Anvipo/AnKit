//
//  CollectionViewSection.SetBoundarySupplementaryItemsError.swift
//  AnKit
//
//  Created by Anvipo on 20.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `set(boundarySupplementaryItems:)` method.
	enum SetBoundarySupplementaryItemsError {
		/// Specified boundary supplementary items are not unique by element kind.
		case duplicateBoundarySupplementaryItemsByElementKind([CollectionViewBoundarySupplementaryItem])
	}
}

extension CollectionViewSection.SetBoundarySupplementaryItemsError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .duplicateBoundarySupplementaryItemsByElementKind(items):
			return """
			Specified boundary supplementary items are not unique by element kind.
			Boundary supplementary items with same element kind: \(items).
			"""
		}
	}
}
