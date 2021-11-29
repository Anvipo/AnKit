//
//  ButtonTVI.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import AnKit
import UIKit

final class ButtonTVI: TableViewItem {
	let text: String

	// swiftlint:disable:next implicitly_unwrapped_optional
	var onTapButton: (() -> Void)!

	override var cellType: TableViewCell.Type {
		ButtonTVC.self
	}

	init(
		text: String,
		onTapButton: @escaping () -> Void = {},
		id: ID = ID()
	) {
		self.text = text
		self.onTapButton = onTapButton

		super.init(id: id)
	}
}
