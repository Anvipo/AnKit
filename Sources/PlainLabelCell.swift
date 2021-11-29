//
//  PlainLabelCell.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

final class PlainLabelCell: CollectionViewCell {
	private let label: UILabel
	private let dividerView: DividerView
	private var labelLeadingConstraint: NSLayoutConstraint?
	private var labelTopConstraint: NSLayoutConstraint?
	private var labelTrailingConstraint: NSLayoutConstraint?
	private var labelBottomConstraint: NSLayoutConstraint?

	override init(frame: CGRect) {
		label = UILabel()
		dividerView = DividerView(model: nil)

		super.init(frame: frame)

		setupUI()
	}

	override func fill(from item: CollectionViewItem, mode: FillMode) {
		super.fill(from: item, mode: mode)

		guard let castedItem = item as? PlainLabelItem else {
			fatalError("Item must be PlainLabelItem")
		}

		label.text = castedItem.text
		label.font = castedItem.textFont
		label.textColor = castedItem.textColor
		label.textAlignment = castedItem.textAlignment
		label.numberOfLines = castedItem.textNumberOfLines

		contentView.tintColor = castedItem.tintColor
		contentView.backgroundColor = castedItem.backgroundColor

		labelLeadingConstraint?.constant = castedItem.textInsets.leading
		labelTopConstraint?.constant = castedItem.textInsets.top
		labelTrailingConstraint?.constant = -castedItem.textInsets.trailing
		labelBottomConstraint?.constant = -castedItem.textInsets.bottom

		dividerView.isHidden = castedItem.dividerModel == nil
		dividerView.model = castedItem.dividerModel

		if castedItem.isShimmering {
			shimmerableViews.showShimmers()
		} else {
			shimmerableViews.hideShimmers()
		}
	}
}

// MARK: - Private methods
private extension PlainLabelCell {
	func setupUI() {
		shimmerableViews = [label]

		dividerView.setContentHuggingPriority(.required, for: .vertical)
		dividerView.setContentHuggingPriority(.required, for: .horizontal)

		contentView.addSubviewsForConstraintsUse([label, dividerView])

		let labelLeadingConstraint = label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
		self.labelLeadingConstraint = labelLeadingConstraint

		let labelTopConstraint = label.topAnchor.constraint(equalTo: contentView.topAnchor)
		self.labelTopConstraint = labelTopConstraint

		let labelTrailingConstraint = label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		self.labelTrailingConstraint = labelTrailingConstraint

		let labelBottomConstraint = label.bottomAnchor.constraint(equalTo: dividerView.topAnchor)
		self.labelBottomConstraint = labelBottomConstraint

		NSLayoutConstraint.activate([
			labelLeadingConstraint,
			labelTopConstraint,
			labelTrailingConstraint,
			labelBottomConstraint,

			dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
