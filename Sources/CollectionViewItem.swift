//
//  CollectionViewItem.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

/// Abstract DTO for cell.
open class CollectionViewItem: Item {
	private var cachedCellHeights: [CellHeightCalculationContext: CGFloat]
	private var cachedCellWidths: [CellWidthCalculationContext: CGFloat]

	/// Type for cell, which will be created and filled from this item.
	open var cellType: CollectionViewCell.Type {
		fatalError("Implement this method in your class")
	}

	override public init(
		typeErasedContent: AnyHashable,
		id: ID = ID()
	) {
		cachedCellHeights = [:]
		cachedCellWidths = [:]

		super.init(
			typeErasedContent: typeErasedContent,
			id: id
		)
	}

	/// Returns cached cell width.
	/// - Parameter context: Context for cell width calculation.
	open func cachedCellWidth(context: CellWidthCalculationContext) -> CGFloat? {
		cachedCellWidths[context]
	}

	/// Caches specified `cellWidth`.
	/// - Parameters:
	///   - cellWidth: Cell width, which would be cached.
	///   - context: Context for cell width calculation.
	open func cache(cellWidth: CGFloat, context: CellWidthCalculationContext) {
		cachedCellWidths[context] = cellWidth
	}

	/// Invalidates all cached cell widths.
	open func invalidateCachedCellWidths() {
		cachedCellWidths.removeAll()
	}

	/// Returns cached cell height.
	/// - Parameter context: Context for cell height calculation.
	open func cachedCellHeight(context: CellHeightCalculationContext) -> CGFloat? {
		cachedCellHeights[context]
	}

	/// Caches specified `cellHeight`.
	/// - Parameters:
	///   - cellHeight: Cell height, which would be cached.
	///   - context: Context for cell height calculation.
	open func cache(cellHeight: CGFloat, context: CellHeightCalculationContext) {
		cachedCellHeights[context] = cellHeight
	}

	/// Invalidates all cached cell heights.
	open func invalidateCachedCellHeights() {
		cachedCellHeights.removeAll()
	}
}

public extension CollectionViewItem {
	/// Calculates width, which cell will fill.
	/// - Parameter context: Context for cell width calculation.
	func cellWidth(context: CellWidthCalculationContext) throws -> CGFloat {
		if let cachedCellWidth = cachedCellWidth(context: context) {
			return cachedCellWidth
		}

		let cellForCalculations = cellType.init()
		cellForCalculations.fill(
			from: self,
			mode: .fromLayout(layoutMode: .widthCalculation(context: context))
		)
		let result = cellForCalculations.contentView.actualContentWidth(availableHeight: context.availableHeightForCell)

		if !result.isNormal {
			throw CellWidthCalculationError.isNotNormal(
				calculatedWidth: result,
				item: self,
				cell: cellForCalculations,
				context: context
			)
		}

		if result < .zero {
			throw CellWidthCalculationError.isLessThanZero(
				calculatedWidth: result,
				item: self,
				cell: cellForCalculations,
				context: context
			)
		}

		cache(cellWidth: result, context: context)
		return result
	}

	/// Calculates height, which cell will fill.
	/// - Parameter context: Context for cell height calculation.
	func cellHeight(context: CellHeightCalculationContext) throws -> CGFloat {
		if let cachedHeight = cachedCellHeight(context: context) {
			return cachedHeight
		}

		let cellForCalculations = cellType.init()
		cellForCalculations.fill(
			from: self,
			mode: .fromLayout(layoutMode: .heightCalculation(context: context))
		)
		let result = cellForCalculations.contentView.actualContentHeight(width: context.availableWidthForCell)

		if !result.isNormal {
			throw CellHeightCalculationError.isNotNormal(
				calculatedHeight: result,
				item: self,
				cell: cellForCalculations,
				context: context
			)
		}

		if result < .zero {
			throw CellHeightCalculationError.isLessThanZero(
				calculatedHeight: result,
				item: self,
				cell: cellForCalculations,
				context: context
			)
		}

		cache(cellHeight: result, context: context)
		return result
	}
}

extension Array where Element == CollectionViewItem {
	func hasSameContent(as other: [CollectionViewItem]) -> Bool {
		guard count == other.count else {
			return false
		}

		for index in indices {
			let lhs = self[index]
			let rhs = other[index]

			if lhs.typeErasedContent != rhs.typeErasedContent {
				return false
			}
		}

		return true
	}
}
