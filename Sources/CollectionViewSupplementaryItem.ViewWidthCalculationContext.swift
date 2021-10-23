//
//  CollectionViewSupplementaryItem.ViewWidthCalculationContext.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import CoreGraphics

public extension CollectionViewSupplementaryItem {
	/// Context for supplementary view width calculation.
	struct ViewWidthCalculationContext {
		/// Available height for supplementary view.
		public let availableHeightForSupplementaryView: CGFloat

		/// Information about the current layout environment.
		public let layoutEnvironment: AnyNSCollectionLayoutEnvironment

		/// Initializes with specified parameters.
		/// - Parameters:
		///   - availableHeightForSupplementaryView: Available height for supplementary view.
		///   - layoutEnvironment: Information about the current layout environment.
		public init(
			availableHeightForSupplementaryView: CGFloat,
			layoutEnvironment: AnyNSCollectionLayoutEnvironment
		) {
			self.availableHeightForSupplementaryView = availableHeightForSupplementaryView
			self.layoutEnvironment = layoutEnvironment
		}
	}
}

extension CollectionViewSupplementaryItem.ViewWidthCalculationContext: Equatable {}

extension CollectionViewSupplementaryItem.ViewWidthCalculationContext: Hashable {}
