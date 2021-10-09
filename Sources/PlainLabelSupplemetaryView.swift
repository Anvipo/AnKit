//
//  PlainLabelSupplemetaryView.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

final class PlainLabelSupplemetaryView: CollectionViewSupplementaryView {
	private let blurredView: BlurredView
	private let label: UILabel
	private var currentLabelConstraints: [NSLayoutConstraint]
	private var currentLabelInsets: NSDirectionalEdgeInsets

	override init(frame: CGRect) {
		blurredView = BlurredView(style: .regular)
		label = UILabel()
		currentLabelConstraints = []
		currentLabelInsets = .zero

		super.init(frame: frame)

		setupUI()
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		currentLabelConstraints = []
		currentLabelInsets = .zero
	}

	override func fill(from item: CollectionViewSupplementaryItem, context: FillContext) {
		super.fill(from: item, context: context)

		guard let castedItem = item as? PlainLabelSupplemetaryItem else {
			fatalError("Item must be PlainLabelSupplemetaryItem")
		}

		label.text = castedItem.text
		label.tintColor = castedItem.tintColor
		label.font = castedItem.textFont
		label.textColor = castedItem.textColor
		label.textAlignment = castedItem.textAlignment
		label.numberOfLines = castedItem.textNumberOfLines

		blurredView.tintColor = castedItem.tintColor
		blurredView.set(style: castedItem.blurEffectStyle)

		tintColor = castedItem.tintColor
		backgroundColor = castedItem.backgroundColor

		let newLabelInsets = castedItem.textInsets

		if currentLabelConstraints.isEmpty || newLabelInsets != currentLabelInsets {
			currentLabelInsets = newLabelInsets
			NSLayoutConstraint.deactivate(currentLabelConstraints)
			currentLabelConstraints = label.makeConstraints(to: self, insets: newLabelInsets)
			NSLayoutConstraint.activate(currentLabelConstraints)
		}

		if castedItem.isShimmering {
			shimmerableViews.showShimmers()
		} else {
			shimmerableViews.hideShimmers()
		}
	}
}

// MARK: - Private methods
private extension PlainLabelSupplemetaryView {
	func setupUI() {
		shimmerableViews = [label]

		[blurredView, label].addAsSubviewForConstraintsUse(to: self)
		NSLayoutConstraint.activate(blurredView.makeConstraints(to: self))
	}
}
