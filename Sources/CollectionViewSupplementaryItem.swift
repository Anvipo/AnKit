//
//  CollectionViewSupplementaryItem.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// DTO for supplementary view in collection view.
open class CollectionViewSupplementaryItem: Item {
	private var cachedSupplementaryViewHeights: [CGFloat: CGFloat]
	private var cachedSupplementaryViewWidths: [CGFloat: CGFloat]

	/// The amount of space between the content of the view and its boundaries.
	public let contentInsets: NSDirectionalEdgeInsets

	/// A Boolean value that indicates whether a view is pinned
	/// to the top or bottom visible boundary of the section or layout it's attached to.
	public let pinToVisibleBounds: Bool

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
	///   - typeErasedContent: Content, which will be used for identifing item.
	///   - elementKind: A string that identifies the type of supplementary item.
	///   - contentInsets: The amount of space between the content of the item and its boundaries.
	///   - pinToVisibleBounds: A Boolean value that indicates whether a header is pinned
	///   to the top or bottom visible boundary of the section or layout it's attached to.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		typeErasedContent: AnyHashable,
		elementKind: String,
		contentInsets: NSDirectionalEdgeInsets = .zero,
		pinToVisibleBounds: Bool = false,
		id: ID = ID()
	) {
		self.elementKind = elementKind
		self.contentInsets = contentInsets
		self.pinToVisibleBounds = pinToVisibleBounds

		cachedSupplementaryViewHeights = [:]
		cachedSupplementaryViewWidths = [:]

		super.init(
			typeErasedContent: typeErasedContent,
			id: id
		)
	}

	/// Returns cached supplementary view width.
	/// - Parameter availableHeight: Available height for supplementary view.
	open func cachedSupplementaryViewWidth(for availableHeight: CGFloat) -> CGFloat? {
		cachedSupplementaryViewWidths[availableHeight]
	}

	/// Caches specified `supplementaryViewWidth`.
	/// - Parameters:
	///   - supplementaryViewWidth: Supplementary view width, which would be cached.
	///   - availableHeight: Available height for supplementary view.
	open func cache(supplementaryViewWidth: CGFloat, for availableHeight: CGFloat) {
		cachedSupplementaryViewWidths[availableHeight] = supplementaryViewWidth
	}

	/// Clears all cached supplementary view widths.
	open func clearCachedSupplementaryViewWidths() {
		cachedSupplementaryViewWidths.removeAll()
	}

	/// Returns cached supplementary view height.
	/// - Parameter availableWidth: Available width for supplementary view.
	open func cachedSupplementaryViewHeight(for availableWidth: CGFloat) -> CGFloat? {
		cachedSupplementaryViewHeights[availableWidth]
	}

	/// Caches specified `supplementaryViewHeight`.
	/// - Parameters:
	///   - supplementaryViewHeight: Supplementary view height, which would be cached.
	///   - availableWidth: Available width for supplementary view.
	open func cache(supplementaryViewHeight: CGFloat, for availableWidth: CGFloat) {
		cachedSupplementaryViewHeights[availableWidth] = supplementaryViewHeight
	}

	/// Clears all cached supplementary view heights.
	open func clearCachedSupplementaryViewHeights() {
		cachedSupplementaryViewHeights.removeAll()
	}
}

public extension CollectionViewSupplementaryItem {
	/// Calculates width, which supplementary view will fill.
	/// - Parameter availableHeight: Available height for supplementary view.
	func supplementaryViewWidth(availableHeight: CGFloat) throws -> CGFloat {
		if let cachedSupplementaryViewWidth = cachedSupplementaryViewWidth(for: availableHeight) {
			return cachedSupplementaryViewWidth
		}

		let supplementaryViewForCalculations = supplementaryViewType.init()
		supplementaryViewForCalculations.fill(
			from: self,
			context: CollectionViewSupplementaryView.FillContext(
				availableWidth: nil,
				availableHeight: availableHeight
			)
		)
		let result = supplementaryViewForCalculations.actualContentWidth(availableHeight: availableHeight)

		if !result.isNormal {
			throw WidthCalculateError.isNotNormal(
				calculatedWidth: result,
				item: self,
				view: supplementaryViewForCalculations,
				availableHeight: availableHeight
			)
		}

		if result < .zero {
			throw WidthCalculateError.isLessThanZero(
				calculatedWidth: result,
				item: self,
				view: supplementaryViewForCalculations,
				availableHeight: availableHeight
			)
		}

		cache(supplementaryViewWidth: result, for: availableHeight)
		return result
	}

	/// Calculates height, which supplementary view will fill.
	/// - Parameter availableWidth: Available width for supplementary view.
	func supplementaryViewHeight(availableWidth: CGFloat) throws -> CGFloat {
		if let cachedHeight = cachedSupplementaryViewHeight(for: availableWidth) {
			return cachedHeight
		}

		let supplementaryViewForCalculations = supplementaryViewType.init()
		supplementaryViewForCalculations.fill(
			from: self,
			context: CollectionViewSupplementaryView.FillContext(
				availableWidth: availableWidth,
				availableHeight: nil
			)
		)
		let result = supplementaryViewForCalculations.actualContentHeight(width: availableWidth)

		if !result.isNormal {
			throw HeightCalculateError.isNotNormal(
				calculatedHeight: result,
				item: self,
				view: supplementaryViewForCalculations,
				availableWidth: availableWidth
			)
		}

		if result < .zero {
			throw HeightCalculateError.isLessThanZero(
				calculatedHeight: result,
				item: self,
				view: supplementaryViewForCalculations,
				availableWidth: availableWidth
			)
		}

		cache(supplementaryViewHeight: result, for: availableWidth)
		return result
	}
}
