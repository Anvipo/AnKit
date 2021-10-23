//
//  CollectionViewSupplementaryItem.ViewWidthCalculationError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewSupplementaryItem {
	/// Error, which could occure in calculating item's view width.
	enum ViewWidthCalculationError {
		/// Width is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			calculatedWidth: CGFloat,
			item: CollectionViewSupplementaryItem,
			view: CollectionViewSupplementaryView,
			context: CollectionViewSupplementaryItem.ViewWidthCalculationContext
		)

		/// Width is less than zero.
		case isLessThanZero(
			calculatedWidth: CGFloat,
			item: CollectionViewSupplementaryItem,
			view: CollectionViewSupplementaryView,
			context: CollectionViewSupplementaryItem.ViewWidthCalculationContext
		)
	}
}

extension CollectionViewSupplementaryItem.ViewWidthCalculationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(calculatedWidth, item, view, context):
			return """
			Calculated width \(calculatedWidth) of view \(view) is not normal.
			Check that your supplementary view subviews property is not empty.
			Item: \(item).
			Context: \(context)
			"""

		case let .isLessThanZero(calculatedWidth, item, view, context):
			return """
			Calculated width \(calculatedWidth) of view \(view) is less than zero.
			Check that your supplementary view subviews property is not empty.
			Item: \(item).
			Context: \(context)
			"""
		}
	}
}
