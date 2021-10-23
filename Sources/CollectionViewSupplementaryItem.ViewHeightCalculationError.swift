//
//  CollectionViewSupplementaryItem.ViewHeightCalculationError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewSupplementaryItem {
	/// Error, which could occure in calculating item's view height.
	enum ViewHeightCalculationError {
		/// Height is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			calculatedHeight: CGFloat,
			item: CollectionViewSupplementaryItem,
			view: CollectionViewSupplementaryView,
			context: CollectionViewSupplementaryItem.ViewHeightCalculationContext
		)

		/// Height is less than zero.
		case isLessThanZero(
			calculatedHeight: CGFloat,
			item: CollectionViewSupplementaryItem,
			view: CollectionViewSupplementaryView,
			context: CollectionViewSupplementaryItem.ViewHeightCalculationContext
		)
	}
}

extension CollectionViewSupplementaryItem.ViewHeightCalculationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(calculatedHeight, item, view, context):
			return """
			Calculated height \(calculatedHeight) of view \(view) is not normal.
			Check that your supplementary view subviews property is not empty.
			Item: \(item).
			Context: \(context)
			"""

		case let .isLessThanZero(calculatedHeight, item, view, context):
			return """
			Calculated height \(calculatedHeight) of view \(view) is less than zero.
			Check that your supplementary view subviews property is not empty.
			Item: \(item).
			Context: \(context)
			"""
		}
	}
}
