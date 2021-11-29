//
//  ButtonTVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import AnKit
import UIKit

final class ButtonTVC: TableViewCell {
	private let button: Button

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		button = Button()

		super.init(style: style, reuseIdentifier: reuseIdentifier)

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

	override func fill(from item: TableViewItem, mode: FillMode) {
		super.fill(from: item, mode: mode)

		guard let castedItem = item as? ButtonTVI else {
			assertionFailure("?")
			return
		}

		button.setup(
			text: castedItem.text,
			onTap: castedItem.onTapButton
		)
	}
}

private extension ButtonTVC {
	func setupUI() {
		contentView.addSubviewForConstraintsUse(button)
		NSLayoutConstraint.activate(button.makeConstraints(to: contentView))
	}
}
