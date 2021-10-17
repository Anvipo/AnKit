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
	private let headerItem: CollectionViewSupplementaryItem?
	private let footerItem: CollectionViewSupplementaryItem?
	private let backgroundDecorationItem: PlainListBackgroundDecorationItem?

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

		var supplementaryItems = [String: CollectionViewSupplementaryItem]()
		if let headerItem = headerItem {
			supplementaryItems[headerItem.elementKind] = headerItem
		}
		if let footerItem = footerItem {
			if let existingItem = supplementaryItems[footerItem.elementKind] {
				throw InitError.duplicateSupplementaryElementKind(
					elementKind: footerItem.elementKind,
					existingItem: existingItem,
					duplicateItem: footerItem
				)
			}
			supplementaryItems[footerItem.elementKind] = footerItem
		}

		var decorationItems = [String: CollectionViewDecorationItem]()
		if let backgroundDecorationItem = backgroundDecorationItem {
			decorationItems[backgroundDecorationItem.elementKind] = backgroundDecorationItem
		}

		try super.init(
			items: items,
			supplementaryItems: supplementaryItems,
			decorationItems: decorationItems,
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

	// swiftlint:disable:next function_body_length
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
		} else {
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
