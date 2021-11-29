//
//  ChangeLayoutSection.swift
//  AnKitPlayground
//
//  Created by Anvipo on 10.11.2021.
//

import AnKit
import UIKit

final class ChangeLayoutSection: CollectionViewSection {
	var mode: Mode

	init(
		mode: Mode,
		items: [CollectionViewItem]
	) throws {
		self.mode = mode

		try super.init(
			items: items
		)
	}

	override func layoutConfiguration(
		context: LayoutCreationContext
	) -> NSCollectionLayoutSection {
		switch mode {
		case .cardsListLayout:
			return cardsListLayout(context: context)

		case .threeSmallUnderOneBigLayout:
			return threeSmallUnderOneBigLayout(context: context)

		case .gridLayout:
			return gridLayout(context: context)

		case .plainListLayout:
			// swiftlint:disable:next force_try
			return try! listLayout(context: context)
		}
	}
}

private extension ChangeLayoutSection {
	func cardsListLayout(
		context: LayoutCreationContext
	) -> NSCollectionLayoutSection {
		let layoutItem = NSCollectionLayoutItem(
			layoutSize: .fullSize
		)

		layoutItem.contentInsets = .default

		let verticalGroupLayout = NSCollectionLayoutGroup.vertical(
			layoutSize: .fullWidth(heightDimension: .fractionalHeight(1 / 3)),
			subitem: layoutItem,
			count: 1
		)

		return NSCollectionLayoutSection(group: verticalGroupLayout)
	}

	func threeSmallUnderOneBigLayout(
		context: LayoutCreationContext
	) -> NSCollectionLayoutSection {
		let smallItemCount = 3
		let smallItemLayout = NSCollectionLayoutItem(
			layoutSize: .fullHeight(
				widthDimension: .fractionalWidth(1 / CGFloat(smallItemCount))
			)
		)
		smallItemLayout.contentInsets = NSDirectionalEdgeInsets(
			horizontalInset: 2
		)

		let smallItemsGroupLayoutFractionalHeight: CGFloat = 1 / 3
		let bigItemLayoutFractionalHeight: CGFloat = 1 - smallItemsGroupLayoutFractionalHeight

		let smallItemsGroupLayout = NSCollectionLayoutGroup.horizontal(
			layoutSize: .fullWidth(
				heightDimension: .fractionalHeight(smallItemsGroupLayoutFractionalHeight)
			),
			subitem: smallItemLayout,
			count: smallItemCount
		)
		smallItemsGroupLayout.contentInsets = NSDirectionalEdgeInsets(
			horizontalInset: 0,
			verticalInset: 2
		)

		let bigItemLayout = NSCollectionLayoutItem(
			layoutSize: .fullWidth(
				heightDimension: .fractionalHeight(bigItemLayoutFractionalHeight)
			)
		)
		bigItemLayout.contentInsets = NSDirectionalEdgeInsets(
			horizontalInset: 2,
			verticalInset: 2
		)

		let groupLayout = NSCollectionLayoutGroup.vertical(
			// half screen height
			layoutSize: .fullWidth(heightDimension: .fractionalHeight(1 / 2)),
			subitems: [bigItemLayout, smallItemsGroupLayout]
		)

		return NSCollectionLayoutSection(group: groupLayout)
	}

	func gridLayout(
		context: LayoutCreationContext
	) -> NSCollectionLayoutSection {
		let smallItemCount = 3
		let itemLayout = NSCollectionLayoutItem(
			layoutSize: .square(fractionalWidth: 1 / CGFloat(smallItemCount))
		)
		itemLayout.contentInsets = NSDirectionalEdgeInsets(
			horizontalInset: 1,
			verticalInset: 1
		)

		let groupLayout = NSCollectionLayoutGroup.horizontal(
			layoutSize: .fullWidth(
				heightDimension: itemLayout.layoutSize.heightDimension
			),
			subitem: itemLayout,
			count: smallItemCount
		)

		return NSCollectionLayoutSection(group: groupLayout)
	}

	func listLayout(context: LayoutCreationContext) throws -> NSCollectionLayoutSection {
		let effectiveContentWidth = effectiveContentWidth(layoutEnvironment: context.layoutEnvironment)

		return sectionListLayout(
			context: context,
			effectiveContentWidth: effectiveContentWidth
		)
	}

	func sectionListLayout(
		context: LayoutCreationContext,
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
				layoutEnvironment: context.layoutEnvironment
			)
		}

		// iOS < 14

		let cellHeightCalculationContext = CollectionViewItem.CellHeightCalculationContext(
			availableWidthForCell: effectiveContentWidth,
			layoutEnvironment: AnyNSCollectionLayoutEnvironment(context.layoutEnvironment)
		)

		let layoutItems: [NSCollectionLayoutItem] = items.map { item in
			do {
				let cellHeight = try item.cellHeight(
					context: cellHeightCalculationContext
				)

				return NSCollectionLayoutItem(
					layoutSize: .fullWidth(heightDimension: .absolute(cellHeight))
				)
			} catch {
				return NSCollectionLayoutItem(
					layoutSize: .fullWidth(heightDimension: .estimated(44))
				)
			}
		}

		let contentHeight = layoutItems.map { $0.layoutSize.heightDimension.dimension }.sum

		let verticalGroupLayout = NSCollectionLayoutGroup.vertical(
			layoutSize: .fullWidth(heightDimension: .absolute(contentHeight)),
			subitems: layoutItems
		)

		return NSCollectionLayoutSection(group: verticalGroupLayout)
	}
}
