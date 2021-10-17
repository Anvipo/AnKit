//
//  InfoCardCell.swift
//  AnKitPlayground
//
//  Created by Anvipo on 17.10.2021.
//

import AnKit
import UIKit

final class InfoCardCell: CollectionViewCell {
	private let imageView: UIImageView
	private let label: UILabel
	private let footnoteLabel: UILabel
	// swiftlint:disable implicitly_unwrapped_optional
	private var labelTopConstraint: NSLayoutConstraint!
	private var labelBottomConstraint: NSLayoutConstraint!
	// swiftlint:enable implicitly_unwrapped_optional
	private weak var item: InfoCardItem?

	override init(frame: CGRect) {
		imageView = UIImageView()
		label = UILabel()
		footnoteLabel = UILabel()

		super.init(frame: frame)

		setupUI()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		guard let item = item,
			  !item.isShimmering
		else {
			contentView.resetShadowParameters()
			return
		}

		contentView.addDefaultShadow(shadowColor: Color.shadow.uiColor)
	}

	override func fill(
		from item: CollectionViewItem,
		context: FillContext
	) {
		super.fill(from: item, context: context)
		guard let castedItem = item as? InfoCardItem else {
			assertionFailure("?")
			return
		}

		self.item = castedItem

		let labelParagraphStyle = NSMutableParagraphStyle()
		labelParagraphStyle.lineSpacing = 4
		labelParagraphStyle.alignment = .center
		labelParagraphStyle.lineBreakMode = .byTruncatingTail

		label.attributedText = NSAttributedString(
			string: castedItem.content.text,
			attributes: [.paragraphStyle: labelParagraphStyle.copy()]
		)

		footnoteLabel.text = castedItem.content.footnoteText

		if castedItem.content.footnoteText.isEmpty {
			labelBottomConstraint.isActive = false
			labelBottomConstraint = label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
			labelBottomConstraint.isActive = true
		} else {
			labelBottomConstraint.isActive = false
			labelBottomConstraint = label.bottomAnchor.constraint(lessThanOrEqualTo: footnoteLabel.bottomAnchor)
			labelBottomConstraint.isActive = true
		}

		labelTopConstraint.constant = castedItem.isShimmering ? 19 : 5
		labelBottomConstraint.constant = castedItem.isShimmering ? -22 : -5

		if castedItem.isShimmering {
			shimmerableViews.showShimmers()
		} else {
			shimmerableViews.hideShimmers()
		}

		layoutIfNeeded()

		try? setupImage()

		if let imageViewShimmerLayer = imageView.shimmerLayer {
			imageViewShimmerLayer.cornerRadius = imageView.layer.cornerRadius
			imageViewShimmerLayer.maskedCorners = .all
		}
	}
}

extension InfoCardCell: HasImageProviders {
	var imageProviders: [ImageProvider] {
		item?.imageProviders ?? []
	}
}

extension InfoCardCell {
	static let imageViewHeightMultiplier: CGFloat = 0.65
}

private extension InfoCardCell {
	static let labelsOffset: CGFloat = 11

	func setupUI() {
		shimmerableViews = [imageView, label]

		contentView.layer.cornerRadius = 16
		contentView.backgroundColor = Color.tertiarySystemBackground.uiColor

		imageView.layer.cornerRadius = contentView.layer.cornerRadius
		imageView.layer.maskedCorners = .all
		imageView.clipsToBounds = true
		imageView.contentMode = .center

		label.numberOfLines = 2
		label.textColor = Color.label.uiColor
		label.font = Font.body.uiFont

		footnoteLabel.numberOfLines = 1
		footnoteLabel.textColor = Color.secondaryLabel.uiColor
		footnoteLabel.font = Font.footnote.uiFont
		footnoteLabel.textAlignment = .center

		for subview in [imageView, label, footnoteLabel] {
			contentView.addSubview(subview)
			subview.translatesAutoresizingMaskIntoConstraints = false
		}

		labelTopConstraint = label.topAnchor.constraint(equalTo: imageView.bottomAnchor)
		labelBottomConstraint = label.bottomAnchor.constraint(lessThanOrEqualTo: footnoteLabel.bottomAnchor)

		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Self.imageViewHeightMultiplier),

			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.labelsOffset),
			labelTopConstraint,
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.labelsOffset),
			labelBottomConstraint,

			footnoteLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
			footnoteLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
			footnoteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
		])
	}

	func setupImage() throws {
		guard let item = item else {
			return
		}

		imageView.contentMode = item.imageViewContentMode

		// swiftlint:disable:next trailing_closure
		try item.imageProvider.setupImage(
			in: imageView,
			shouldSetImageToImageView: { [weak requestedItem = item, weak self] in
				requestedItem?.id == self?.item?.id
			}
		)
	}
}
