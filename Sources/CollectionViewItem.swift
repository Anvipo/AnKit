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

	/// Supplementary items in item.
	///
	/// Could be empty.
	public let supplementaryItems: [CollectionViewSupplementaryItem]

	/// Type for cell, which will be created and filled from this item.
	open var cellType: CollectionViewCell.Type {
		fatalError("Implement this method in your class")
	}

	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - supplementaryItems: Supplementary items in item.
	///   - id: The stable identity of the entity associated with this instance.
	///
	/// - Throws: `CollectionViewItem.InitError`.
	public init(
		supplementaryItems: [CollectionViewSupplementaryItem] = [],
		id: ID = ID()
	) throws {
		for (_, groupedSupplementaryItems) in Dictionary(grouping: supplementaryItems, by: { $0.elementKind }) {
			if groupedSupplementaryItems.count > 1 {
				throw InitError.duplicateSupplementaryItemsByElementKind(
					supplementaryItemsWithSameElementKind: groupedSupplementaryItems
				)
			}
		}

		self.supplementaryItems = supplementaryItems

		cachedCellHeights = [:]
		cachedCellWidths = [:]

		super.init(id: id)
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

	override open func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)
		hasher.combine(supplementaryItems)
		hasher.combine(cachedCellHeights)
		hasher.combine(cachedCellWidths)
	}
}

public extension CollectionViewItem {
	// swiftlint:disable:next missing_docs
	static func == (
		lhs: CollectionViewItem,
		rhs: CollectionViewItem
	) -> Bool {
		(lhs as Item) == (rhs as Item) &&
		lhs.supplementaryItems == rhs.supplementaryItems &&
		lhs.cachedCellHeights == rhs.cachedCellHeights &&
		lhs.cachedCellWidths == rhs.cachedCellWidths
	}

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

extension CollectionViewItem {
	func supplementaryItem(for kind: String) -> CollectionViewSupplementaryItem? {
		if supplementaryItems.isEmpty {
			return nil
		}

		return supplementaryItems.first { $0.elementKind == kind }
	}
}

extension Array where Element == CollectionViewItem {
	func supplementaryItem(for kind: String) -> CollectionViewSupplementaryItem? {
		if isEmpty {
			return nil
		}

		for item in self {
			if let supplementaryItem = item.supplementaryItem(for: kind) {
				return supplementaryItem
			}
		}

		return nil
	}
}
