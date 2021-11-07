//
//  ButtonCell.swift
//  AnKitPlayground
//
//  Created by Anvipo on 28.09.2021.
//

import AnKit
import UIKit

final class ButtonCell: CollectionViewCell {
	private let button: Button

	override init(frame: CGRect) {
		button = Button()

		super.init(frame: frame)

		setupUI()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		button.layoutIfNeeded()

		button.addDefaultCircleCorners()
		if let buttonBackgroundColor = button.backgroundColor {
			button.addDefaultShadow(shadowColor: buttonBackgroundColor)
		} else {
			assertionFailure("?")
		}
	}

	override func fill(from item: CollectionViewItem, mode: FillMode) {
		super.fill(from: item, mode: mode)

		guard let castedItem = item as? ButtonItem else {
			assertionFailure("?")
			return
		}

		button.setup(
			text: castedItem.text,
			onTap: castedItem.onTapButton
		)
	}
}

private extension ButtonCell {
	func setupUI() {
		contentView.addSubviewForConstraintsUse(button)
		NSLayoutConstraint.activate(button.makeConstraints(to: contentView))
	}
}
