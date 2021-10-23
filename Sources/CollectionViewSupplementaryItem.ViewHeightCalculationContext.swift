//
//  CollectionViewSupplementaryItem.ViewHeightCalculationContext.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import CoreGraphics

public extension CollectionViewSupplementaryItem {
	/// Context for supplementary view height calculation.
	struct ViewHeightCalculationContext {
		/// Available width for supplementary view.
		public let availableWidthForSupplementaryView: CGFloat

		/// Information about the current layout environment.
		public let layoutEnvironment: AnyNSCollectionLayoutEnvironment

		/// Initializes with specified parameters.
		/// - Parameters:
		///   - availableWidthForSupplementaryView: Available width for supplementary view.
		///   - layoutEnvironment: Information about the current layout environment.
		public init(
			availableWidthForSupplementaryView: CGFloat,
			layoutEnvironment: AnyNSCollectionLayoutEnvironment
		) {
			self.availableWidthForSupplementaryView = availableWidthForSupplementaryView
			self.layoutEnvironment = layoutEnvironment
		}
	}
}

extension CollectionViewSupplementaryItem.ViewHeightCalculationContext: Equatable {}

extension CollectionViewSupplementaryItem.ViewHeightCalculationContext: Hashable {}
