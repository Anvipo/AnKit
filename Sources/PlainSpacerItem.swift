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

	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - height: Spacer height.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		height: CGFloat,
		id: ID = ID()
	) throws {
		self.height = height

		try super.init(id: id)
	}

	override public func cachedCellHeight(context: CellHeightCalculationContext) -> CGFloat? {
		height
	}

	override public func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)
		hasher.combine(height)
	}
}

public extension PlainSpacerItem {
	// swiftlint:disable:next missing_docs
	static func == (
		lhs: PlainSpacerItem,
		rhs: PlainSpacerItem
	) -> Bool {
		(lhs as CollectionViewItem) == (rhs as CollectionViewItem) &&
		lhs.height == rhs.height
	}
}
