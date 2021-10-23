//
//  CollectionViewSection.ContentHeightCalculationError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in calculating section height.
	enum ContentHeightCalculationError {
		/// Height is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			section: CollectionViewSection,
			calculatedHeight: CGFloat,
			context: CollectionViewItem.CellHeightCalculationContext
		)

		/// Height is less than zero.
		case isLessThanZero(
			section: CollectionViewSection,
			calculatedHeight: CGFloat,
			context: CollectionViewItem.CellHeightCalculationContext
		)
	}
}

extension CollectionViewSection.ContentHeightCalculationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(
			section,
			calculatedHeight,
			context
		):
			return """
			Calculated content height \(calculatedHeight) of section \(section) is not normal.
			It's invalid.
			Context: \(context)
			"""

		case let .isLessThanZero(
			section,
			calculatedHeight,
			context
		):
			return """
			Calculated content height \(calculatedHeight) of section \(section) is less than zero.
			It's invalid.
			Context: \(context)
			"""
		}
	}
}
