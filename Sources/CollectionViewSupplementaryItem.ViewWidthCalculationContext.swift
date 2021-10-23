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
	}
}

extension CollectionViewSupplementaryItem.ViewWidthCalculationContext: Equatable {}

extension CollectionViewSupplementaryItem.ViewWidthCalculationContext: Hashable {}
