//
//  CollectionViewItem.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import CoreGraphics

/// Abstract DTO for cell.
open class CollectionViewItem: Item {
	private var cachedCellHeights: [CGFloat: CGFloat]
	private var cachedCellWidths: [CGFloat: CGFloat]

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
	/// - Parameter availableHeight: Available height for cell.
	open func cachedCellWidth(for availableHeight: CGFloat) -> CGFloat? {
		cachedCellWidths[availableHeight]
	}

	/// Caches specified `cellWidth`.
	/// - Parameters:
	///   - cellWidth: Cell width, which would be cached.
	///   - availableHeight: Available height for cell.
	open func cache(cellWidth: CGFloat, for availableHeight: CGFloat) {
		cachedCellWidths[availableHeight] = cellWidth
	}

	/// Invalidates all cached cell widths.
	open func invalidateCachedCellWidths() {
		cachedCellWidths.removeAll()
	}

	/// Returns cached cell height.
	/// - Parameter availableWidth: Available width for cell.
	open func cachedCellHeight(for availableWidth: CGFloat) -> CGFloat? {
		cachedCellHeights[availableWidth]
	}

	/// Caches specified `cellHeight`.
	/// - Parameters:
	///   - cellHeight: Cell height, which would be cached.
	///   - availableWidth: Available width for cell.
	open func cache(cellHeight: CGFloat, for availableWidth: CGFloat) {
		cachedCellHeights[availableWidth] = cellHeight
	}

	/// Invalidates all cached cell heights.
	open func invalidateCachedCellHeights() {
		cachedCellHeights.removeAll()
	}
}

public extension CollectionViewItem {
	/// Calculates width, which cell will fill.
	/// - Parameter availableHeight: Available height for cell.
	func cellWidth(availableHeight: CGFloat) throws -> CGFloat {
		if let cachedCellWidth = cachedCellWidth(for: availableHeight) {
			return cachedCellWidth
		}

		let cellForCalculations = cellType.init()
		cellForCalculations.fill(
			from: self,
			context: CollectionViewCell.FillContext(
				availableWidth: nil,
				availableHeight: availableHeight
			)
		)
		let result = cellForCalculations.contentView.actualContentWidth(availableHeight: availableHeight)

		if !result.isNormal {
			throw WidthCalculateError.isNotNormal(
				calculatedWidth: result,
				item: self,
				cell: cellForCalculations,
				availableHeight: availableHeight
			)
		}

		if result < .zero {
			throw WidthCalculateError.isLessThanZero(
				calculatedWidth: result,
				item: self,
				cell: cellForCalculations,
				availableHeight: availableHeight
			)
		}

		cache(cellWidth: result, for: availableHeight)
		return result
	}

	/// Calculates height, which cell will fill.
	/// - Parameter availableWidth: Available width for cell.
	func cellHeight(availableWidth: CGFloat) throws -> CGFloat {
		if let cachedHeight = cachedCellHeight(for: availableWidth) {
			return cachedHeight
		}

		let cellForCalculations = cellType.init()
		cellForCalculations.fill(
			from: self,
			context: CollectionViewCell.FillContext(
				availableWidth: availableWidth,
				availableHeight: nil
			)
		)
		let result = cellForCalculations.contentView.actualContentHeight(width: availableWidth)

		if !result.isNormal {
			throw HeightCalculateError.isNotNormal(
				calculatedHeight: result,
				item: self,
				cell: cellForCalculations,
				availableWidth: availableWidth
			)
		}

		if result < .zero {
			throw HeightCalculateError.isLessThanZero(
				calculatedHeight: result,
				item: self,
				cell: cellForCalculations,
				availableWidth: availableWidth
			)
		}

		cache(cellHeight: result, for: availableWidth)
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
