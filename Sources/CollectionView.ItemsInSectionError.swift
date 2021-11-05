//
//  CollectionView.ItemsInSectionError.swift
//  AnKit
//
//  Created by Anvipo on 07.11.2021.
//

import Foundation

public extension CollectionView {
	/// Error, which could occure in `CollectionView` `items(in:)` method.
	enum ItemsInSectionError {
		/// Specified section was not found in collection view.
		case sectionWasNotFound
	}
}

extension CollectionView.ItemsInSectionError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case .sectionWasNotFound:
			return """
			Specified section was not found in collection view.
			"""
		}
	}
}
