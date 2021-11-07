//
//  ExpandableTextCell.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import AnKit
import UIKit

final class ExpandableTextCell: CollectionViewCell {
	private let textLabel: UILabel
	private let expandButton: Button
	private let stackView: UIStackView

	private weak var item: ExpandableTextItem?

	override init(frame: CGRect) {
		textLabel = UILabel()
		expandButton = Button()
		stackView = UIStackView(arrangedSubviews: [textLabel, expandButton])

		super.init(frame: frame)

		setupUI()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		expandButton.layoutIfNeeded()
		expandButton.addDefaultShadow(shadowColor: Color.shadow.uiColor)
	}

	override func fill(from item: CollectionViewItem, mode: FillMode) {
		super.fill(from: item, mode: mode)

		guard let castedItem = item as? ExpandableTextItem else {
			assertionFailure("?")
			return
		}

		self.item = castedItem

		if let animationDuration = castedItem.animationDuration {
			textLabel.layer.addAnimatedTransition(
				type: castedItem.textLabelTransitionType,
				duration: animationDuration
			)
			expandButton.layer.addAnimatedTransition(
				type: castedItem.textLabelTransitionType,
				duration: animationDuration
			)
		}

		if castedItem.isExpanded {
			textLabel.numberOfLines = 0
			expandButton.setTitle("Hide", for: .normal)
		} else {
			textLabel.numberOfLines = 3
			expandButton.setTitle("Show", for: .normal)
		}

		// swiftlint:disable:next force_cast
		let detailsParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		detailsParagraphStyle.lineSpacing = 10

		textLabel.attributedText = NSAttributedString(
			string: castedItem.text,
			attributes: [.paragraphStyle: detailsParagraphStyle.copy()]
		)

		guard let availableWidth = mode.availableWidthForCell else {
			assertionFailure("?")
			return
		}

		let actualNumberOfLines = textLabel.actualNumberOfLines(availableWidth: availableWidth)
		expandButton.isHidden = actualNumberOfLines <= textLabel.numberOfLines
	}
}

private extension ExpandableTextCell {
	func didTapExpandButton() {
		guard let item = item else {
			assertionFailure("?")
			return
		}

		item.onTapExpandButton()
	}

	func setupUI() {
		textLabel.font = Font.body.uiFont
		textLabel.textColor = Color.label.uiColor

		expandButton.onTap = { [weak self] in
			self?.didTapExpandButton()
		}
		expandButton.backgroundColor = Color.secondarySystemBackground.uiColor
		expandButton.setTitleColor(Color.label.uiColor, for: .normal)
		expandButton.contentEdgeInsets = .default()
		expandButton.titleLabel?.font = Font.callout.uiFont
		let expandButtonHeight = Button.defaultExtendedTapAreaHeight
		expandButton.layer.cornerRadius = expandButtonHeight / 2

		stackView.axis = .vertical
		stackView.spacing = 16

		for subview in [stackView] {
			contentView.addSubview(subview)
			subview.translatesAutoresizingMaskIntoConstraints = false
		}

		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			expandButton.heightAnchor.constraint(equalToConstant: expandButtonHeight)
		])
	}
}
