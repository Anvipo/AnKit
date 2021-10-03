//
//  CollectionViewSupplementaryView.FillContext.swift
//  AnKit
//
//  Created by Anvipo on 03.10.2021.
//

import CoreGraphics

public extension CollectionViewSupplementaryView {
	/// Context for view for `fill(from:context:)` method.
	struct FillContext {
		/// Available width for view.
		public let availableWidth: CGFloat?

		/// Available height for view.
		public let availableHeight: CGFloat?
	}
}
