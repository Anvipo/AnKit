//
//  PlainListSection.HeightCalculateError.swift
//  AnKit
//
//  Created by Anvipo on 25.09.2021.
//
// swiftlint:disable enum_case_associated_values_count

import UIKit

public extension PlainListSection {
	/// Error, which could occure in calculating section height.
	enum ContentHeightCalculateError {
		/// Height is not normal (zero, subnormal, infinity, or NaN).
		case isNotNormal(
			section: PlainListSection,
			calculatedHeight: CGFloat,
			availableWidth: CGFloat,
			layoutEnvironment: NSCollectionLayoutEnvironment,
			layoutItems: [NSCollectionLayoutItem]
		)

		/// Height is less than zero.
		case isLessThanZero(
			section: PlainListSection,
			calculatedHeight: CGFloat,
			availableWidth: CGFloat,
			layoutEnvironment: NSCollectionLayoutEnvironment,
			layoutItems: [NSCollectionLayoutItem]
		)
	}
}

extension PlainListSection.ContentHeightCalculateError: LocalizedError {
	public var errorDescription: String? {
		switch self {
		case let .isNotNormal(
			section,
			calculatedHeight,
			availableWidth,
			layoutEnvironment,
			layoutItems
		):
			return """
			Calculated content height \(calculatedHeight) of section \(section) is not normal.
			It's invalid.
			Available width: \(availableWidth)
			Layout environment: \(layoutEnvironment)
			Layout items: \(layoutItems)
			"""

		case let .isLessThanZero(
			section,
			calculatedHeight,
			availableWidth,
			layoutEnvironment,
			layoutItems
		):
			return """
			Calculated content height \(calculatedHeight) of section \(section) is less than zero.
			It's invalid.
			Available width: \(availableWidth)
			Layout environment: \(layoutEnvironment)
			Layout items: \(layoutItems)
			"""
		}
	}
}
