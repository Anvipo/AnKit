//
//  CollectionViewSection.RemoveSupplementaryItemError.swift
//  AnKit
//
//  Created by Anvipo on 20.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `remove(supplementaryItem:)` method.
	enum RemoveSupplementaryItemError {
		/// Section does not have specified supplementary item.
		case noSupplementaryItem
	}
}

extension CollectionViewSection.RemoveSupplementaryItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .noSupplementaryItem:
			return "Section does not have specified supplementary item"
		}
	}
}
