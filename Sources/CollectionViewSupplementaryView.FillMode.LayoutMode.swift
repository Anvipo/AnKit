//
//  CollectionViewSupplementaryView.FillMode.LayoutMode.swift
//  AnKit
//
//  Created by Anvipo on 23.10.2021.
//

import CoreGraphics

public extension CollectionViewSupplementaryView.FillMode {
	/// Mode, when `fill(from:mode:)` method is called from collection view layout.
	enum LayoutMode {
		/// Method is called from view height calculation.
		case heightCalculation(availableWidthForView: CGFloat)

		/// Method is called from view width calculation.
		case widthCalculation(availableHeightForView: CGFloat)
	}
}
