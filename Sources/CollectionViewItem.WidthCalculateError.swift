//
//  CollectionViewItem.WidthCalculateError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewItem {
	/// Error, which could occure in calculating item's contentView width.
	enum WidthCalculateError {
		/// Width is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			calculatedWidth: CGFloat,
			item: CollectionViewItem,
			cell: CollectionViewCell,
			availableHeight: CGFloat
		)

		/// Width is less than zero.
		case isLessThanZero(
			calculatedWidth: CGFloat,
			item: CollectionViewItem,
			cell: CollectionViewCell,
			availableHeight: CGFloat
		)
	}
}

extension CollectionViewItem.WidthCalculateError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(calculatedWidth, item, cell, availableHeight):
			return """
			Calculated width \(calculatedWidth) of cell \(cell) is not normal.
			Check that your contentView subviews property is not empty.
			Item: \(item).
			Available height: \(availableHeight)
			"""

		case let .isLessThanZero(calculatedWidth, item, cell, availableHeight):
			return """
			Calculated width \(calculatedWidth) of cell \(cell) is less than zero.
			Check that your contentView subviews property is not empty.
			Item: \(item).
			Available height: \(availableHeight)
			"""
		}
	}
}
