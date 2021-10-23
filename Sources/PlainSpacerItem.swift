//
//  PlainSpacerItem.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

/// DTO for plain spacer between items in sections.
public final class PlainSpacerItem: CollectionViewItem {
	let height: CGFloat

	override public var cellType: CollectionViewCell.Type {
		PlainSpacerCell.self
	}

	/// Initializes item with specified `height`.
	/// - Parameter height: Spacer height.
	public init(height: CGFloat) {
		self.height = height

		super.init(typeErasedContent: height)
	}

	override public func cachedCellHeight(context: CellHeightCalculationContext) -> CGFloat? {
		height
	}
}
