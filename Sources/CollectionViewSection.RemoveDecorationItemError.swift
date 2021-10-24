//
//  CollectionViewSection.RemoveDecorationItemError.swift
//  AnKit
//
//  Created by Anvipo on 21.10.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in `CollectionViewSection` `remove(decoration:)` method.
	enum RemoveDecorationItemError {
		/// Section does not have specified decoration item.
		case noDecorationItem
	}
}

extension CollectionViewSection.RemoveDecorationItemError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .noDecorationItem:
			return "Section does not have specified decoration item"
		}
	}
}
