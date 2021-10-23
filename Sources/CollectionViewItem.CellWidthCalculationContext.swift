//
//  CollectionViewItem.CellWidthCalculationContext.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import CoreGraphics

public extension CollectionViewItem {
	/// Context for cell width calculation.
	struct CellWidthCalculationContext {
		/// Available height for cell.
		public let availableHeightForCell: CGFloat

		/// Information about the current layout environment.
		public let layoutEnvironment: AnyNSCollectionLayoutEnvironment
	}
}

extension CollectionViewItem.CellWidthCalculationContext: Equatable {}

extension CollectionViewItem.CellWidthCalculationContext: Hashable {}
