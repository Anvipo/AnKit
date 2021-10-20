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
public final class PlainListSection: CollectionViewSection {
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
		let availableWidth = layoutEnvironment.container.effectiveContentSize.width
		- contentInsets.leading
		- contentInsets.trailing

		let widthLayoutDimension = NSCollectionLayoutDimension.absolute(availableWidth)

		let sectionLayout = sectionLayout(
			layoutEnvironment: layoutEnvironment,
			widthLayoutDimension: widthLayoutDimension
		)
		sectionLayout.contentInsets = contentInsets
		sectionLayout.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler

		let headerViewHeight: CGFloat?
		if let headerItem = headerItem {
			let headerLayout = supplementaryLayout(
				item: headerItem,
				widthLayoutDimension: widthLayoutDimension,
				alignment: .top
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
				widthLayoutDimension: widthLayoutDimension,
				alignment: .bottom
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
}

private extension PlainListSection {
	func supplementaryLayout(
		item: CollectionViewSupplementaryItem,
		widthLayoutDimension: NSCollectionLayoutDimension,
		alignment: NSRectAlignment
	) -> NSCollectionLayoutBoundarySupplementaryItem {
		let supplementaryViewHeight = try! item.supplementaryViewHeight(
			availableWidth: widthLayoutDimension.dimension
		)

		let supplementarySize = NSCollectionLayoutSize(
			widthDimension: widthLayoutDimension,
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
		widthLayoutDimension: NSCollectionLayoutDimension
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

		let layoutItems: [NSCollectionLayoutItem] = items.map { item in
			let cellHeight = try! item.cellHeight(
				availableWidth: widthLayoutDimension.dimension
			)

			return NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(
					widthDimension: widthLayoutDimension,
					heightDimension: .absolute(cellHeight)
				)
			)
		}

		let contentHeight = layoutItems
			.map { $0.layoutSize.heightDimension.dimension }
			.sum

		if !contentHeight.isNormal {
			let error = ContentHeightCalculateError.isNotNormal(
				section: self,
				calculatedHeight: contentHeight,
				availableWidth: widthLayoutDimension.dimension,
				layoutEnvironment: layoutEnvironment,
				layoutItems: layoutItems
			)
			assertionFailure(error.localizedDescription)
		}

		if contentHeight < .zero {
			let error = ContentHeightCalculateError.isLessThanZero(
				section: self,
				calculatedHeight: contentHeight,
				availableWidth: widthLayoutDimension.dimension,
				layoutEnvironment: layoutEnvironment,
				layoutItems: layoutItems
			)
			assertionFailure(error.localizedDescription)
		}

		let verticalGroupLayout = NSCollectionLayoutGroup.vertical(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: widthLayoutDimension,
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
