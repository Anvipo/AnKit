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

	var content: Content

	var canResponseToTap: Bool
	var onTap: (() -> Void)?

	var isShimmering: Bool

	override var cellType: CollectionViewCell.Type {
		InfoCardCell.self
	}

	init(
		content: Content,
		imageViewContentMode: UIView.ContentMode
	) {
		self.content = content
		self.imageViewContentMode = imageViewContentMode

		imageProvider = ImageProvider(
			imageContent: content.imageContent
		)

		canResponseToTap = true

		isShimmering = false

		super.init(typeErasedContent: content)
	}
}

extension InfoCardItem: HasImageProviders {
	var imageProviders: [ImageProvider] {
		[imageProvider]
	}
}

extension InfoCardItem: Tappable {}

extension InfoCardItem: Shimmerable {}
