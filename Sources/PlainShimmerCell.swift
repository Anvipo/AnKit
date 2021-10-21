//
//  PlainShimmerCell.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

final class PlainShimmerCell: CollectionViewCell {
	private var heightConstraint: NSLayoutConstraint?

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.addDefaultShimmer()

		let heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 0)
		self.heightConstraint = heightConstraint
		NSLayoutConstraint.activate([heightConstraint])
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		contentView.shimmerLayer?.frame = contentView.frame
		contentView.layer.addDefaultCircleCorners()
		contentView.layer.masksToBounds = true
	}

	override func fill(from item: CollectionViewItem, mode: FillMode) {
		super.fill(from: item, mode: mode)

		guard let castedItem = item as? PlainShimmerItem else {
			fatalError("Item must be PlainShimmerItem")
		}

		heightConstraint?.constant = castedItem.height
	}
}
