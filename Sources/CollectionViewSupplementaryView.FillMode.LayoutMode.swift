//
//  CollectionViewSupplementaryView.FillMode.LayoutMode.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

public extension CollectionViewSupplementaryView.FillMode {
	/// Mode, when `fill(from:mode:)` method is called from collection view layout.
	enum LayoutMode {
		/// Method is called from view height calculation.
		case heightCalculation(context: CollectionViewSupplementaryItem.ViewHeightCalculationContext)

		/// Method is called from view width calculation.
		case widthCalculation(context: CollectionViewSupplementaryItem.ViewWidthCalculationContext)
	}
}
