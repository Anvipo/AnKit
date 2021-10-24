//
//  InfoCardItem.Content.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import AnKit

extension InfoCardItem {
	struct Content: Hashable {
		let imageContent: ImageContent
		let text: String
		let footnoteText: String

		init(
			imageContent: ImageContent,
			text: String,
			footnoteText: String = ""
		) {
			self.imageContent = imageContent
			self.text = text
			self.footnoteText = footnoteText
		}
	}
}
