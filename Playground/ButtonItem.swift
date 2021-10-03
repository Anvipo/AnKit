//
//  ButtonItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 28.09.2021.
//

import AnKit
import UIKit

final class ButtonItem: CollectionViewItem {
	let text: String

	// swiftlint:disable:next implicitly_unwrapped_optional
	var onTapButton: (() -> Void)!

	override var cellType: CollectionViewCell.Type {
		ButtonCell.self
	}

	init(
		text: String,
		onTapButton: @escaping () -> Void = {}
	) {
		self.text = text
		self.onTapButton = onTapButton

		super.init(typeErasedContent: text)
	}
}
