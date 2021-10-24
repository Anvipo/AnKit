//
//  CollectionViewSupplementaryItem.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// DTO for supplementary view in collection view.
open class CollectionViewSupplementaryItem: Item {
	private var cachedSupplementaryViewHeights: [ViewHeightCalculationContext: CGFloat]
	private var cachedSupplementaryViewWidths: [ViewWidthCalculationContext: CGFloat]

	/// The amount of space between the content of the view and its boundaries.
	public let contentInsets: NSDirectionalEdgeInsets

	/// A string that identifies the type of supplementary view.
	///
	/// Must be same in all collection view lifecycle.
	public let elementKind: String

	/// Type for supplementary view, which will be created and filled from this item.
	open var supplementaryViewType: CollectionViewSupplementaryView.Type {
		fatalError("Implement this method in your class")
	}

	/// Initializes item with specified parameters.
	/// - Parameters:
	///   - elementKind: A string that identifies the type of supplementary item.
	///   - contentInsets: The amount of space between the content of the item and its boundaries.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		elementKind: String,
		contentInsets: NSDirectionalEdgeInsets = .zero,
		id: ID = ID()
	) {
		self.elementKind = elementKind
		self.contentInsets = contentInsets

		cachedSupplementaryViewHeights = [:]
		cachedSupplementaryViewWidths = [:]

		super.init(id: id)
	}

	/// Returns cached supplementary view width.
	/// - Parameter context: Context for supplementary view width calculation.
	open func cachedSupplementaryViewWidth(context: ViewWidthCalculationContext) -> CGFloat? {
		cachedSupplementaryViewWidths[context]
	}

	/// Caches specified `supplementaryViewWidth`.
	/// - Parameters:
	///   - supplementaryViewWidth: Supplementary view width, which would be cached.
	///   - context: Context for supplementary view width calculation.
	open func cache(supplementaryViewWidth: CGFloat, context: ViewWidthCalculationContext) {
		cachedSupplementaryViewWidths[context] = supplementaryViewWidth
	}

	/// Invalidates all cached supplementary view widths.
	open func invalidateCachedSupplementaryViewWidths() {
		cachedSupplementaryViewWidths.removeAll()
	}

	/// Returns cached supplementary view height.
	/// - Parameter context: Context for supplementary view height calculation.
	open func cachedSupplementaryViewHeight(context: ViewHeightCalculationContext) -> CGFloat? {
		cachedSupplementaryViewHeights[context]
	}

	/// Caches specified `supplementaryViewHeight`.
	/// - Parameters:
	///   - supplementaryViewHeight: Supplementary view height, which would be cached.
	///   - context: Context for supplementary view height calculation.
	open func cache(supplementaryViewHeight: CGFloat, context: ViewHeightCalculationContext) {
		cachedSupplementaryViewHeights[context] = supplementaryViewHeight
	}

	/// Invalidates all cached supplementary view heights.
	open func invalidateCachedSupplementaryViewHeights() {
		cachedSupplementaryViewHeights.removeAll()
	}

	override open func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)
		hasher.combine(contentInsets)
		hasher.combine(elementKind)
		hasher.combine(cachedSupplementaryViewHeights)
		hasher.combine(cachedSupplementaryViewWidths)
	}
}

public extension CollectionViewSupplementaryItem {
	// swiftlint:disable:next missing_docs
	static func == (
		lhs: CollectionViewSupplementaryItem,
		rhs: CollectionViewSupplementaryItem
	) -> Bool {
		(lhs as Item) == (rhs as Item) &&
		lhs.contentInsets == rhs.contentInsets &&
		lhs.elementKind == rhs.elementKind &&
		lhs.cachedSupplementaryViewHeights == rhs.cachedSupplementaryViewHeights &&
		lhs.cachedSupplementaryViewWidths == rhs.cachedSupplementaryViewWidths
	}

	/// Calculates width, which supplementary view will fill.
	/// - Parameter context: Context for supplementary view width calculation.
	func supplementaryViewWidth(context: ViewWidthCalculationContext) throws -> CGFloat {
		if let cachedSupplementaryViewWidth = cachedSupplementaryViewWidth(context: context) {
			return cachedSupplementaryViewWidth
		}

		let supplementaryViewForCalculations = supplementaryViewType.init()
		supplementaryViewForCalculations.fill(
			from: self,
			mode: .fromLayout(.widthCalculation(context: context))
		)
		let result = supplementaryViewForCalculations.actualContentWidth(availableHeight: context.availableHeightForSupplementaryView)

		if !result.isNormal {
			throw ViewWidthCalculationError.isNotNormal(
				calculatedWidth: result,
				item: self,
				view: supplementaryViewForCalculations,
				context: context
			)
		}

		if result < .zero {
			throw ViewWidthCalculationError.isLessThanZero(
				calculatedWidth: result,
				item: self,
				view: supplementaryViewForCalculations,
				context: context
			)
		}

		cache(supplementaryViewWidth: result, context: context)
		return result
	}

	/// Calculates height, which supplementary view will fill.
	/// - Parameter context: Context for supplementary view height calculation.
	func supplementaryViewHeight(context: ViewHeightCalculationContext) throws -> CGFloat {
		if let cachedHeight = cachedSupplementaryViewHeight(context: context) {
			return cachedHeight
		}

		let supplementaryViewForCalculations = supplementaryViewType.init()
		supplementaryViewForCalculations.fill(
			from: self,
			mode: .fromLayout(.heightCalculation(context: context))
		)
		let result = supplementaryViewForCalculations.actualContentHeight(width: context.availableWidthForSupplementaryView)

		if !result.isNormal {
			throw ViewHeightCalculationError.isNotNormal(
				calculatedHeight: result,
				item: self,
				view: supplementaryViewForCalculations,
				context: context
			)
		}

		if result < .zero {
			throw ViewHeightCalculationError.isLessThanZero(
				calculatedHeight: result,
				item: self,
				view: supplementaryViewForCalculations,
				context: context
			)
		}

		cache(supplementaryViewHeight: result, context: context)
		return result
	}
}
