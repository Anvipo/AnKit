//
//  CollectionViewSection.ContentHeightCalculateError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in calculating section height.
	enum ContentHeightCalculateError {
		/// Height is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			section: CollectionViewSection,
			calculatedHeight: CGFloat,
			availableWidth: CGFloat
		)

		/// Height is less than zero.
		case isLessThanZero(
			section: CollectionViewSection,
			calculatedHeight: CGFloat,
			availableWidth: CGFloat
		)
	}
}

extension CollectionViewSection.ContentHeightCalculateError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(
			section,
			calculatedHeight,
			availableWidth
		):
			return """
			Calculated content height \(calculatedHeight) of section \(section) is not normal.
			It's invalid.
			Available width: \(availableWidth)
			"""

		case let .isLessThanZero(
			section,
			calculatedHeight,
			availableWidth
		):
			return """
			Calculated content height \(calculatedHeight) of section \(section) is less than zero.
			It's invalid.
			Available width: \(availableWidth)
			"""
		}
	}
}
