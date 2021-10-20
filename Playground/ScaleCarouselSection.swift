//
//  ScaleCarouselSection.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import AnKit
import UIKit

final class ScaleCarouselSection: CollectionViewSection {
	private let itemWidthDimension: NSCollectionLayoutDimension
	private let itemHeightDimension: NSCollectionLayoutDimension
	private let interItemSpacing: CGFloat

	@available(*, unavailable)
	override var visibleItemsInvalidationHandler: NSCollectionLayoutSectionVisibleItemsInvalidationHandler? {
		get {
			super.visibleItemsInvalidationHandler
		}
		set {
			// swiftlint:disable:previous unused_setter_value
			fatalError("Do not use this method")
		}
	}

	init(
		items: [CollectionViewItem],
		itemWidthDimension: NSCollectionLayoutDimension,
		itemHeightDimension: NSCollectionLayoutDimension,
		interItemSpacing: CGFloat = .zero,
		contentInsets: NSDirectionalEdgeInsets = .zero
	) throws {
		self.itemWidthDimension = itemWidthDimension
		self.itemHeightDimension = itemHeightDimension
		self.interItemSpacing = interItemSpacing

		try super.init(
			items: items,
			contentInsets: contentInsets
		)

		super.visibleItemsInvalidationHandler = { [weak self] visibleItems, scrollOffset, layoutEnvironment in
			self?.visibleItemsInvalidationHandler(
				visibleItems: visibleItems,
				scrollOffset: scrollOffset,
				layoutEnvironment: layoutEnvironment
			)
		}
	}

	override func layoutConfiguration(
		layoutEnvironment: NSCollectionLayoutEnvironment
	) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)

		let groupSize = NSCollectionLayoutSize(
			widthDimension: itemWidthDimension,
			heightDimension: itemHeightDimension
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitem: item,
			count: 1
		)

		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = contentInsets
		section.orthogonalScrollingBehavior = .continuous
		section.interGroupSpacing = interItemSpacing
		section.visibleItemsInvalidationHandler = visibleItemsInvalidationHandler

		return section
	}
}

private extension ScaleCarouselSection {
	func visibleItemsInvalidationHandler(
		visibleItems: [NSCollectionLayoutVisibleItem],
		scrollOffset: CGPoint,
		layoutEnvironment: NSCollectionLayoutEnvironment
	) {
		let containerWidth = layoutEnvironment.container.effectiveContentSize.width

		for visibleItem in visibleItems {
			let distanceFromCenter = abs((visibleItem.frame.midX - scrollOffset.x) - containerWidth / 2)
			let minScale: CGFloat = 0.7
			let maxScale: CGFloat = 1
			let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
			visibleItem.transform = CGAffineTransform(scaleX: scale, y: scale)
		}
	}
}
