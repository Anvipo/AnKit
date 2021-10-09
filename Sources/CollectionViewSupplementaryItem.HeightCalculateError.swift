//
//  CollectionViewSupplementaryItem.HeightCalculateError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewSupplementaryItem {
	/// Error, which could occure in calculating item's view height.
	enum HeightCalculateError {
		/// Height is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			calculatedHeight: CGFloat,
			item: CollectionViewSupplementaryItem,
			view: CollectionViewSupplementaryView,
			availableWidth: CGFloat
		)

		/// Height is less than zero.
		case isLessThanZero(
			calculatedHeight: CGFloat,
			item: CollectionViewSupplementaryItem,
			view: CollectionViewSupplementaryView,
			availableWidth: CGFloat
		)
	}
}

extension CollectionViewSupplementaryItem.HeightCalculateError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(calculatedHeight, item, view, availableWidth):
			return """
			Calculated height \(calculatedHeight) of view \(view) is not normal.
			Check that your supplementary view subviews property is not empty.
			Item: \(item).
			Available width: \(availableWidth)
			"""

		case let .isLessThanZero(calculatedHeight, item, view, availableWidth):
			return """
			Calculated height \(calculatedHeight) of view \(view) is less than zero.
			Check that your supplementary view subviews property is not empty.
			Item: \(item).
			Available width: \(availableWidth)
			"""
		}
	}
}
