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

	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - height: Height of item.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		height: CGFloat,
		id: ID = ID()
	) throws {
		self.height = height

		try super.init(id: id)
	}

	override public func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)
		hasher.combine(height)
	}
}

public extension PlainShimmerItem {
	// swiftlint:disable:next missing_docs
	static func == (
		lhs: PlainShimmerItem,
		rhs: PlainShimmerItem
	) -> Bool {
		(lhs as CollectionViewItem) == (rhs as CollectionViewItem) &&
		lhs.height == rhs.height
	}
}
