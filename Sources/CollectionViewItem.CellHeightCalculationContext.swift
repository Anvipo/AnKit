//
//  CollectionViewItem.CellHeightCalculationContext.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import CoreGraphics

public extension CollectionViewItem {
	/// Context for cell height calculation.
	struct CellHeightCalculationContext {
		/// Available width for cell.
		public let availableWidthForCell: CGFloat

		/// Information about the current layout environment.
		public let layoutEnvironment: AnyNSCollectionLayoutEnvironment

		/// Initializes with specified parameters.
		/// - Parameters:
		///   - availableWidthForCell: Available width for cell.
		///   - layoutEnvironment: Information about the current layout environment.
		public init(
			availableWidthForCell: CGFloat,
			layoutEnvironment: AnyNSCollectionLayoutEnvironment
		) {
			self.availableWidthForCell = availableWidthForCell
			self.layoutEnvironment = layoutEnvironment
		}
	}
}

extension CollectionViewItem.CellHeightCalculationContext: Equatable {}

extension CollectionViewItem.CellHeightCalculationContext: Hashable {}
