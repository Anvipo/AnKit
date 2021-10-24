//
//  CollectionViewSection.AppendBoundarySupplementaryItemError.swift
//  AnKit
//
//  Created by Anvipo on 20.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `append(boundarySupplementaryItem:)` method.
	enum AppendBoundarySupplementaryItemError {
		/// Specified boundary supplementary item is not unique by element kind.
		case duplicateBoundarySupplementaryItem(CollectionViewSupplementaryItem)
	}
}

extension CollectionViewSection.AppendBoundarySupplementaryItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .duplicateBoundarySupplementaryItem(item):
			return """
			Specified boundary supplementary item is not unique by element kind.
			Existing boundary supplementary item with same element kind: \(item).
			"""
		}
	}
}
