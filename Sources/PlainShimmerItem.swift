//
//  PlainShimmerItem.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import CoreGraphics

/// DTO for plain shimmer in sections.
public final class PlainShimmerItem: CollectionViewItem {
	override public var cellType: CollectionViewCell.Type {
		PlainShimmerCell.self
	}

	let height: CGFloat

	/// Initializes item with specified `height`.
	/// - Parameter height: Height of item.
	public init(height: CGFloat) throws {
		self.height = height

		try super.init(typeErasedContent: height)
	}
}
