//
//  PlainListSection.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//
// swiftlint:disable force_try

import UIKit

/// List-based section.
///
/// Behaves like in table view (full width section).
open class PlainListSection: CollectionViewSection {
	/// Item for header in section.
	public private(set) var headerItem: CollectionViewSupplementaryItem?

	/// Item for footer in section.
	public private(set) var footerItem: CollectionViewSupplementaryItem?

	/// Background decoration item which is anchored to the section.
	public private(set) var backgroundDecorationItem: PlainListBackgroundDecorationItem?

	@available(*, unavailable)
	override public var supplementaryItems: [CollectionViewSupplementaryItem] {
		super.supplementaryItems
	}

	@available(*, unavailable)
	override public var decorationItems: [CollectionViewDecorationItem] {
		super.decorationItems
	}

	/// Initializes section with specified parameters.
	/// - Parameters:
	///   - items: Items in section. Must not be empty.
	///   - headerItem: Item for header in section.
	///   - footerItem: Item for footer in section.
	///   - backgroundDecorationItem: Background decoration item which is anchored to the section.
	///   - contentInsets: The amount of space between the content of the section and its boundaries.
	///   - visibleItemsInvalidationHandler: A closure called before each layout cycle to allow modification of the items
	///   in the section immediately before they are displayed.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		items: [CollectionViewItem],
		headerItem: CollectionViewSupplementaryItem? = nil,
		footerItem: CollectionViewSupplementaryItem? = nil,
		backgroundDecorationItem: PlainListBackgroundDecorationItem? = nil,
		contentInsets: NSDirectionalEdgeInsets = .zero,
		visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler? = nil,
		id: ID = ID()
	) throws {
		self.headerItem = headerItem
		self.footerItem = footerItem
		self.backgroundDecorationItem = backgroundDecorationItem

		try super.init(
			items: items,
			supplementaryItems: [headerItem, footerItem].compactMap { $0 },
			decorationItems: [backgroundDecorationItem].compactMap { $0 },
			contentInsets: contentInsets,
			visibleItemsInvalidationHandler: visibleItemsInvalidationHandler,
			id: id
		)
	}

	override public func layoutConfiguration(
		layoutEnvironment: NSCollectionLayoutEnvironment
	) -> NSCollectionLayoutSection {
		let effectiveContentWidth = effectiveContentWidth(layoutEnvironment: layoutEnvironment)

		let sectionLayout = sectionLayout(
			layoutEnvironment: layoutEnvironment,
			effectiveContentWidth: effectiveContentWidth
		)
		sectionLayout.contentInsets = contentInsets
		sectionLayout.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler

		let headerViewHeight: CGFloat?
		if let headerItem = headerItem {
			let headerLayout = supplementaryLayout(
				item: headerItem,
				alignment: .top,
				effectiveContentWidth: effectiveContentWidth,
				layoutEnvironment: layoutEnvironment
			)
			sectionLayout.boundarySupplementaryItems.append(headerLayout)

			headerViewHeight = headerLayout.layoutSize.heightDimension.dimension
		} else {
			headerViewHeight = nil
		}

		let footerViewHeight: CGFloat?
		if let footerItem = footerItem {
			let footerLayout = supplementaryLayout(
				item: footerItem,
				alignment: .bottom,
				effectiveContentWidth: effectiveContentWidth,
				layoutEnvironment: layoutEnvironment
			)
			sectionLayout.boundarySupplementaryItems.append(footerLayout)

			footerViewHeight = footerLayout.layoutSize.heightDimension.dimension
		} else {
			footerViewHeight = nil
		}

		if let backgroundDecorationItem = backgroundDecorationItem {
			let backgroundItemLayout = backgroundItemLayout(
				backgroundDecorationItem: backgroundDecorationItem,
				headerViewHeight: headerViewHeight,
				footerViewHeight: footerViewHeight,
				sectionContentInsets: sectionLayout.contentInsets
			)

			sectionLayout.decorationItems = [backgroundItemLayout]
		}

		return sectionLayout
	}

	@available(*, unavailable)
	override public func set(supplementaryItems: [CollectionViewSupplementaryItem]) throws {
		fatalError("Do not use this method. Use set(headerItem:) or set(footerItem:) methods instead.")
	}

	@available(*, unavailable)
	override public func remove(supplementaryItem: CollectionViewSupplementaryItem) throws {
		fatalError("Do not use this method. Use set(headerItem:) or set(footerItem:) methods instead.")
	}

	@available(*, unavailable)
	override public func append(supplementaryItem: CollectionViewSupplementaryItem) throws {
		fatalError("Do not use this method. Use set(headerItem:) or set(footerItem:) methods instead.")
	}

	@available(*, unavailable)
	override public func set(decorationItems: [CollectionViewDecorationItem]) throws {
		fatalError("Do not use this method. Use set(backgroundDecorationItem:) methods instead.")
	}

	@available(*, unavailable)
	override public func remove(decorationItem: CollectionViewDecorationItem) throws {
		fatalError("Do not use this method. Use set(backgroundDecorationItem:) methods instead.")
	}

	@available(*, unavailable)
	override public func append(decorationItem: CollectionViewDecorationItem) throws {
		fatalError("Do not use this method. Use set(backgroundDecorationItem:) methods instead.")
	}
}

public extension PlainListSection {
	/// Sets specified header item.
	/// - Parameter headerItem: Header item, which will be set.
	func set(headerItem: CollectionViewSupplementaryItem?) throws {
		if let oldHeaderItem = self.headerItem {
			try super.remove(supplementaryItem: oldHeaderItem)
		}

		if let newHeaderItem = headerItem {
			try super.append(supplementaryItem: newHeaderItem)
		}

		self.headerItem = headerItem
	}

	/// Sets specified footer item.
	/// - Parameter footerItem: Footer item, which will be set.
	func set(footerItem: CollectionViewSupplementaryItem?) throws {
		if let oldFooterItem = self.footerItem {
			try super.remove(supplementaryItem: oldFooterItem)
		}

		if let newFooterItem = footerItem {
			try super.append(supplementaryItem: newFooterItem)
		}

		self.footerItem = footerItem
	}

	/// Sets specified background decoration item.
	/// - Parameter backgroundDecorationItem: Background decoration item, which will be set.
	func set(backgroundDecorationItem: PlainListBackgroundDecorationItem?) throws {
		if let oldBackgroundDecorationItem = self.backgroundDecorationItem {
			try super.remove(decorationItem: oldBackgroundDecorationItem)
		}

		if let newBackgroundDecorationItem = backgroundDecorationItem {
			try super.append(decorationItem: newBackgroundDecorationItem)
		}

		self.backgroundDecorationItem = backgroundDecorationItem
	}

	/// Calculates section height.
	/// - Parameter context: Context for cell height calculation.
	func contentHeight(context: CollectionViewItem.CellHeightCalculationContext) throws -> CGFloat {
		let result = try items
			.map { try $0.cellHeight(context: context) }
			.sum

		if !result.isNormal {
			throw ContentHeightCalculationError.isNotNormal(
				calculatedHeight: result,
				cellHeightCalculationContext: context
			)
		}

		if result < .zero {
			throw ContentHeightCalculationError.isLessThanZero(
				calculatedHeight: result,
				cellHeightCalculationContext: context
			)
		}

		return result
	}

	/// Calculates average cell height.
	/// - Parameter context: Context for cell height calculation.
	func contentAverageHeight(context: CollectionViewItem.CellHeightCalculationContext) throws -> CGFloat {
		let cellHeights = try contentHeight(context: context)

		return cellHeights / CGFloat(items.count)
	}
}

private extension PlainListSection {
	func supplementaryLayout(
		item: CollectionViewSupplementaryItem,
		alignment: NSRectAlignment,
		effectiveContentWidth: CGFloat,
		layoutEnvironment: NSCollectionLayoutEnvironment
	) -> NSCollectionLayoutBoundarySupplementaryItem {
		let supplementaryViewHeight = try! item.supplementaryViewHeight(
			context: CollectionViewSupplementaryItem.ViewHeightCalculationContext(
				availableWidthForSupplementaryView: effectiveContentWidth,
				layoutEnvironment: AnyNSCollectionLayoutEnvironment(layoutEnvironment)
			)
		)

		let supplementarySize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(supplementaryViewHeight)
		)
		let supplementaryLayout = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: supplementarySize,
			elementKind: item.elementKind,
			alignment: alignment
		)
		supplementaryLayout.contentInsets = item.contentInsets
		supplementaryLayout.pinToVisibleBounds = item.pinToVisibleBounds

		return supplementaryLayout
	}

	func sectionLayout(
		layoutEnvironment: NSCollectionLayoutEnvironment,
		effectiveContentWidth: CGFloat
	) -> NSCollectionLayoutSection {
		if #available(iOS 14, *) {
			var sectionConfiguration = UICollectionLayoutListConfiguration(
				appearance: .plain
			)
			sectionConfiguration.showsSeparators = false
			sectionConfiguration.backgroundColor = .clear

			return .list(
				using: sectionConfiguration,
				layoutEnvironment: layoutEnvironment
			)
		}

		// iOS < 14

		let cellHeightCalculationContext = CollectionViewItem.CellHeightCalculationContext(
			availableWidthForCell: effectiveContentWidth,
			layoutEnvironment: AnyNSCollectionLayoutEnvironment(layoutEnvironment)
		)

		let layoutItems: [NSCollectionLayoutItem] = items.map { item in
			let cellHeight = try! item.cellHeight(
				context: cellHeightCalculationContext
			)

			return NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(
					widthDimension: .fractionalWidth(1),
					heightDimension: .absolute(cellHeight)
				)
			)
		}

		let contentHeight = try! contentHeight(context: cellHeightCalculationContext)

		let verticalGroupLayout = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1),
				heightDimension: .absolute(contentHeight)
			),
			subitems: layoutItems
		)

		return NSCollectionLayoutSection(group: verticalGroupLayout)
	}

	func backgroundItemLayout(
		backgroundDecorationItem: PlainListBackgroundDecorationItem,
		headerViewHeight: CGFloat?,
		footerViewHeight: CGFloat?,
		sectionContentInsets: NSDirectionalEdgeInsets
	) -> NSCollectionLayoutDecorationItem {
		let backgroundItemLayout = NSCollectionLayoutDecorationItem.background(
			elementKind: backgroundDecorationItem.elementKind
		)

		backgroundItemLayout.contentInsets = sectionContentInsets.copy(
			top: backgroundDecorationItem.ignoresHeader ? headerViewHeight : nil,
			bottom: backgroundDecorationItem.ignoresFooter ? footerViewHeight : nil
		)

		return backgroundItemLayout
	}
}
