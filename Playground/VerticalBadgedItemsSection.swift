//
//  VerticalBadgedItemsSection.swift
//  AnKitPlayground
//
//  Created by Anvipo on 23.10.2021.
//

import AnKit
import UIKit

final class VerticalBadgedItemsSection: CollectionViewSection {
	private let itemSize: NSCollectionLayoutSize
	private let interItemSpacing: CGFloat
	private let headerItem: CollectionViewBoundarySupplementaryItem?

	init(
		items: [InfoCardItem],
		itemSize: NSCollectionLayoutSize,
		headerItem: CollectionViewBoundarySupplementaryItem?,
		interItemSpacing: CGFloat = .zero,
		contentInsets: NSDirectionalEdgeInsets = .zero
	) throws {
		self.itemSize = itemSize
		self.interItemSpacing = interItemSpacing
		self.headerItem = headerItem

		try super.init(
			items: items,
			boundarySupplementaryItems: [headerItem].compactMap { $0 },
			contentInsets: contentInsets
		)
	}

	override func layoutConfiguration(
		context: LayoutCreationContext
	) -> NSCollectionLayoutSection {
		let effectiveContentWidth = effectiveContentWidthLayoutDimension(layoutEnvironment: context.layoutEnvironment)

		// swiftlint:disable:next force_try
		let verticalGroup = try! verticalGroupLayout(
			effectiveContentWidth: effectiveContentWidth,
			layoutEnvironment: context.layoutEnvironment
		)

		let section = NSCollectionLayoutSection(group: verticalGroup)
		section.contentInsets = contentInsets

		if let headerItem = headerItem {
			let context = CollectionViewSupplementaryItem.ViewHeightCalculationContext(
				availableWidthForSupplementaryView: context.layoutEnvironment.container.effectiveContentSize.width,
				layoutEnvironment: AnyNSCollectionLayoutEnvironment(context.layoutEnvironment)
			)
			let headerSize = NSCollectionLayoutSize(
				widthDimension: .absolute(context.availableWidthForSupplementaryView),
				// swiftlint:disable:next force_try
				heightDimension: .absolute(try! headerItem.supplementaryViewHeight(context: context))
			)
			let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
				layoutSize: headerSize,
				elementKind: headerItem.elementKind,
				alignment: .top
			)
			sectionHeader.pinToVisibleBounds = headerItem.pinToVisibleBounds
			sectionHeader.contentInsets = headerItem.contentInsets
			section.boundarySupplementaryItems = [sectionHeader]
		}

		return section
	}
}

private extension VerticalBadgedItemsSection {
	func verticalGroupLayout(
		effectiveContentWidth: NSCollectionLayoutDimension,
		layoutEnvironment: NSCollectionLayoutEnvironment
	) throws -> NSCollectionLayoutGroup {
		let context = CollectionViewSupplementaryItem.ViewWidthCalculationContext(
			availableHeightForSupplementaryView: 20,
			layoutEnvironment: AnyNSCollectionLayoutEnvironment(layoutEnvironment)
		)

		let horizontalGroupLayouts: [NSCollectionLayoutGroup] = try _items.chunked(into: 3).map { itemsInRow in
			let itemLayouts = try itemsInRow.map { try itemInRowLayout(itemInRow: $0, context: context) }

			let horizontalGroup = NSCollectionLayoutGroup.horizontal(
				layoutSize: .fullWidth(heightDimension: itemSize.heightDimension),
				subitems: itemLayouts
			)
			horizontalGroup.interItemSpacing = .flexible(interItemSpacing)
			return horizontalGroup
		}

		let contentHeight = horizontalGroupLayouts.map { $0.layoutSize.heightDimension.dimension }.sum +
		CGFloat(horizontalGroupLayouts.count - 1) * 24

		let verticalGroup = NSCollectionLayoutGroup.vertical(
			layoutSize: .fullWidth(heightDimension: .absolute(contentHeight)),
			subitems: horizontalGroupLayouts
		)
		verticalGroup.interItemSpacing = .fixed(24)

		return verticalGroup
	}

	func itemInRowLayout(
		itemInRow: InfoCardItem,
		context: CollectionViewSupplementaryItem.ViewWidthCalculationContext
	) throws -> NSCollectionLayoutItem {
		let badgeItemLayout: NSCollectionLayoutSupplementaryItem?
		if let badgeItem = itemInRow.badgeItem {
			badgeItemLayout = try badgeLayout(badgeItem: badgeItem, context: context)
		} else {
			badgeItemLayout = nil
		}

		return NSCollectionLayoutItem(
			layoutSize: itemSize,
			supplementaryItems: [badgeItemLayout].compactMap { $0 }
		)
	}

	func badgeLayout(
		badgeItem: InfoCardItem.BadgeItem,
		context: CollectionViewSupplementaryItem.ViewWidthCalculationContext
	) throws -> NSCollectionLayoutSupplementaryItem? {
		let badgeWidth = try badgeItem.supplementaryViewWidth(context: context)
		let badgeSide = max(badgeWidth, context.availableHeightForSupplementaryView)

		return NSCollectionLayoutSupplementaryItem(
			layoutSize: NSCollectionLayoutSize(
				widthDimension: .absolute(badgeSide),
				heightDimension: .absolute(badgeSide)
			),
			elementKind: badgeItem.elementKind,
			containerAnchor: badgeItem.containerAnchor
		)
	}
}

private extension VerticalBadgedItemsSection {
	var _items: [InfoCardItem] {
		// swiftlint:disable:next force_cast
		items.map { $0 as! InfoCardItem }
	}
}
