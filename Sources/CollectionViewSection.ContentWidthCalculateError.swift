//
//  CollectionViewSection.ContentWidthCalculateError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//

import CoreGraphics
import Foundation

public extension CollectionViewSection {
	/// Error, which could occure in calculating section width.
	enum ContentWidthCalculateError {
		/// Width is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			section: CollectionViewSection,
			calculatedWidth: CGFloat,
			availableHeight: CGFloat
		)

		/// Width is less than zero.
		case isLessThanZero(
			section: CollectionViewSection,
			calculatedWidth: CGFloat,
			availableHeight: CGFloat
		)
	}
}

extension CollectionViewSection.ContentWidthCalculateError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(
			section,
			calculatedWidth,
			availableHeight
		):
			return """
			Calculated content width \(calculatedWidth) of section \(section) is not normal.
			It's invalid.
			Available height: \(availableHeight)
			"""

		case let .isLessThanZero(
			section,
			calculatedWidth,
			availableHeight
		):
			return """
			Calculated content width \(calculatedWidth) of section \(section) is less than zero.
			It's invalid.
			Available height: \(availableHeight)
			"""
		}
	}
}
