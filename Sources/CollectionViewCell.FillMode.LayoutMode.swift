//
//  CollectionViewCell.FillMode.LayoutMode.swift
//  AnKit
//
//  Created by Anvipo on 21.10.2021.
//

import CoreGraphics

public extension CollectionViewCell.FillMode {
	/// Mode, when `fill(from:mode:)` method is called from collection view layout.
	enum LayoutMode {
		/// Method is called from cell height calculation.
		case heightCalculation(context: CollectionViewItem.CellHeightCalculationContext)

		/// Method is called from cell width calculation.
		case widthCalculation(context: CollectionViewItem.CellWidthCalculationContext)
	}
}
