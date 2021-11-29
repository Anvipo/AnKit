//
//  InfoCardItem.BadgeView.swift
//  AnKitPlayground
//
//  Created by Anvipo on 23.10.2021.
//

import AnKit
import UIKit

extension InfoCardItem {
	final class BadgeView: CollectionViewSupplementaryView {
		private let label: UILabel
		private var labelLeadingConstraint: NSLayoutConstraint?
		private var labelTopConstraint: NSLayoutConstraint?
		private var labelTrailingConstraint: NSLayoutConstraint?
		private var labelBottomConstraint: NSLayoutConstraint?

		override init(frame: CGRect) {
			label = UILabel()

			super.init(frame: frame)

			setupUI()
		}

		override func layoutSubviews() {
			super.layoutSubviews()
			layer.addDefaultCircleCorners()
		}

		override func fill(from item: CollectionViewSupplementaryItem, mode: FillMode) {
			super.fill(from: item, mode: mode)
			guard let castedItem = item as? InfoCardItem.BadgeItem else {
				assertionFailure("?")
				return
			}

			label.text = castedItem.text
			label.font = castedItem.textFont
			label.textColor = castedItem.textColor
			label.textAlignment = castedItem.textAlignment
			label.numberOfLines = castedItem.textNumberOfLines

			tintColor = castedItem.tintColor
			backgroundColor = castedItem.backgroundColor

			labelLeadingConstraint?.constant = castedItem.textInsets.leading
			labelTopConstraint?.constant = castedItem.textInsets.top
			labelTrailingConstraint?.constant = -castedItem.textInsets.trailing
			labelBottomConstraint?.constant = -castedItem.textInsets.bottom
		}
	}
}

private extension InfoCardItem.BadgeView {
	func setupUI() {
		addSubviewForConstraintsUse(label)

		let labelLeadingConstraint = label.leadingAnchor.constraint(equalTo: leadingAnchor)
		self.labelLeadingConstraint = labelLeadingConstraint

		let labelTopConstraint = label.topAnchor.constraint(equalTo: topAnchor)
		self.labelTopConstraint = labelTopConstraint

		let labelTrailingConstraint = label.trailingAnchor.constraint(equalTo: trailingAnchor)
		self.labelTrailingConstraint = labelTrailingConstraint

		let labelBottomConstraint = label.bottomAnchor.constraint(equalTo: bottomAnchor)
		self.labelBottomConstraint = labelBottomConstraint

		NSLayoutConstraint.activate([
			labelLeadingConstraint,
			labelTopConstraint,
			labelTrailingConstraint,
			labelBottomConstraint
		])
	}
}
