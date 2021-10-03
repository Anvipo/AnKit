//
//  CollectionViewCell.FillContext.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

public extension CollectionViewCell {
	/// Context for cell for `fill(from:context:)` method.
	struct FillContext {
		/// Available width for cell.
		public let availableWidth: CGFloat?

		/// Available height for cell.
		public let availableHeight: CGFloat?
	}
}
