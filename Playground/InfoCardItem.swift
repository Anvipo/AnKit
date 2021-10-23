//
//  InfoCardItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import AnKit
import UIKit

final class InfoCardItem: CollectionViewItem {
	let imageProvider: ImageProvider
	let imageViewContentMode: UIView.ContentMode
	let badgeItem: BadgeItem?

	var content: Content

	var canResponseToTap: Bool
	var onTap: (() -> Void)?

	var isShimmering: Bool

	override var cellType: CollectionViewCell.Type {
		InfoCardCell.self
	}

	init(
		content: Content,
		imageViewContentMode: UIView.ContentMode,
		badgeItem: BadgeItem? = nil
	) throws {
		self.content = content
		self.imageViewContentMode = imageViewContentMode
		self.badgeItem = badgeItem

		imageProvider = ImageProvider(
			imageContent: content.imageContent
		)

		canResponseToTap = true

		isShimmering = false

		try super.init(
			typeErasedContent: content,
			supplementaryItems: [badgeItem].compactMap { $0 }
		)
	}
}

extension InfoCardItem: HasImageProviders {
	var imageProviders: [ImageProvider] {
		[imageProvider]
	}
}

extension InfoCardItem: Tappable {}

extension InfoCardItem: Shimmerable {}
