//
//  CollectionViewSection.RemoveBoundarySupplementaryItemError.swift
//  AnKit
//
//  Created by Anvipo on 20.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `remove(boundarySupplementaryItem:)` method.
	enum RemoveBoundarySupplementaryItemError {
		/// Section does not have specified boundary supplementary item.
		case noSuchBoundarySupplementaryItem
	}
}

extension CollectionViewSection.RemoveBoundarySupplementaryItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .noSuchBoundarySupplementaryItem:
			return "Section does not have specified boundary supplementary item"
		}
	}
}
