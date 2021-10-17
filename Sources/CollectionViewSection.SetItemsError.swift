//
//  CollectionViewSection.SetItemsError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import Foundation

public extension CollectionViewSection {
	/// Error, which could occure, when items is setting.
	enum SetItemsError {
		/// Passed items are empty.
		case itemsAreEmpty
	}
}

extension CollectionViewSection.SetItemsError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .itemsAreEmpty:
			return "Passed items are empty"
		}
	}
}
