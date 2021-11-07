//
//  ExpandableTextItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import AnKit
import CoreGraphics
import Foundation
import QuartzCore

final class ExpandableTextItem: CollectionViewItem {
	private var cachedCellHeights: [CellHeightCalculationContext: CGFloat]

	let text: String
	var animationDuration: TimeInterval?
	var textLabelTransitionType: CATransitionType
	var isExpanded: Bool

	var onTapExpandButton: () -> Void

	override var cellType: CollectionViewCell.Type {
		ExpandableTextCell.self
	}

	init(
		text: String,
		isExpanded: Bool = false,
		animationDuration: TimeInterval? = nil,
		textLabelTransitionType: CATransitionType = .fade,
		id: ID = ID(),
		onTapExpandButton: @escaping () -> Void = {}
	) throws {
		self.text = text
		self.isExpanded = isExpanded
		self.animationDuration = animationDuration
		self.textLabelTransitionType = textLabelTransitionType
		self.onTapExpandButton = onTapExpandButton

		cachedCellHeights = [:]

		try super.init(id: id)
	}

	override func cachedCellHeight(
		context: CollectionViewItem.CellHeightCalculationContext
	) -> CGFloat? {
		let key = CellHeightCalculationContext(
			isExpanded: isExpanded,
			context: context
		)

		return cachedCellHeights[key]
	}

	override func cache(
		cellHeight: CGFloat,
		context: CollectionViewItem.CellHeightCalculationContext
	) {
		let key = CellHeightCalculationContext(
			isExpanded: isExpanded,
			context: context
		)

		cachedCellHeights[key] = cellHeight
	}
}
