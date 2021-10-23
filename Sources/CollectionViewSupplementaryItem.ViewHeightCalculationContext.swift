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
	}
}

extension CollectionViewSupplementaryItem.ViewHeightCalculationContext: Equatable {}

extension CollectionViewSupplementaryItem.ViewHeightCalculationContext: Hashable {}
