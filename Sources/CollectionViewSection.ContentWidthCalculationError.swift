//
//  CollectionViewSection.ContentWidthCalculationError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in calculating section width.
	enum ContentWidthCalculationError {
		/// Width is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			section: CollectionViewSection,
			calculatedWidth: CGFloat,
			context: CollectionViewItem.CellWidthCalculationContext
		)

		/// Width is less than zero.
		case isLessThanZero(
			section: CollectionViewSection,
			calculatedWidth: CGFloat,
			context: CollectionViewItem.CellWidthCalculationContext
		)
	}
}

extension CollectionViewSection.ContentWidthCalculationError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(
			section,
			calculatedWidth,
			context
		):
			return """
			Calculated content width \(calculatedWidth) of section \(section) is not normal.
			It's invalid.
			Context: \(context)
			"""

		case let .isLessThanZero(
			section,
			calculatedWidth,
			context
		):
			return """
			Calculated content width \(calculatedWidth) of section \(section) is less than zero.
			It's invalid.
			Context: \(context)
			"""
		}
	}
}
