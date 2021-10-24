//
//  PlainListSection.ContentHeightCalculationError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import UIKit

public extension PlainListSection {
	/// Error, which could occure in calculating section height.
	enum ContentHeightCalculationError {
		/// Height is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			calculatedHeight: CGFloat,
			cellHeightCalculationContext: CollectionViewItem.CellHeightCalculationContext
		)

		/// Height is less than zero.
		case isLessThanZero(
			calculatedHeight: CGFloat,
			cellHeightCalculationContext: CollectionViewItem.CellHeightCalculationContext
		)
	}
}

extension PlainListSection.ContentHeightCalculationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(calculatedHeight, cellHeightCalculationContext):
			return """
			Calculated content height \(calculatedHeight) of the section is not normal.
			It's invalid.
			Cell height calculation context: \(cellHeightCalculationContext)
			"""

		case let .isLessThanZero(calculatedHeight, cellHeightCalculationContext):
			return """
			Calculated content height \(calculatedHeight) of the section is less than zero.
			It's invalid.
			Cell height calculation context: \(cellHeightCalculationContext)
			"""
		}
	}
}
