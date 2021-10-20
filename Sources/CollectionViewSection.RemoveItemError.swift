//
//  CollectionViewSection.RemoveItemError.swift
//  AnKit
//
//  Created by Anvipo on 21.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `remove(item:)` method.
	enum RemoveItemError {
		/// Section does not have specified item.
		case noItem
	}
}

extension CollectionViewSection.RemoveItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .noItem:
			return "Section does not have specified item"
		}
	}
}
