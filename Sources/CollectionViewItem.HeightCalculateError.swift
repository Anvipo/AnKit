//
//  CollectionViewItem.HeightCalculateError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewItem {
	/// Error, which could occure in calculating item's contentView height.
	enum HeightCalculateError {
		/// Height is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			calculatedHeight: CGFloat,
			item: CollectionViewItem,
			cell: CollectionViewCell,
			availableWidth: CGFloat
		)

		/// Height is less than zero.
		case isLessThanZero(
			calculatedHeight: CGFloat,
			item: CollectionViewItem,
			cell: CollectionViewCell,
			availableWidth: CGFloat
		)
	}
}

extension CollectionViewItem.HeightCalculateError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(calculatedHeight, item, cell, availableWidth):
			return """
			Calculated height \(calculatedHeight) of cell \(cell) is not normal.
			Check that your contentView subviews property is not empty.
			Item: \(item).
			Available width: \(availableWidth)
			"""

		case let .isLessThanZero(calculatedHeight, item, cell, availableWidth):
			return """
			Calculated height \(calculatedHeight) of cell \(cell) is less than zero.
			Check that your contentView subviews property is not empty.
			Item: \(item).
			Available width: \(availableWidth)
			"""
		}
	}
}
