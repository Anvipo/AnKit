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
			textColor: .white,
			textFont: .preferredFont(forTextStyle: .callout),
			tintColor: .systemIndigo,
			backgroundColor: .systemIndigo,
			contentEdgeInsets: UIEdgeInsets(
				top: .defaultHorizontalOffset,
				left: .defaultHorizontalOffset / 2,
				bottom: .defaultHorizontalOffset,
				right: .defaultHorizontalOffset / 2
			),
			onTap: castedItem.onTapButton
		)

		layoutIfNeeded()
	}
}

private extension ButtonCell {
	func setupUI() {
		[button].addAsSubviewForConstraintsUse(to: contentView)
		NSLayoutConstraint.activate(button.makeConstraints(to: contentView))
	}
}
