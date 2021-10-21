//
//  PlainSpacerCell.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

final class PlainSpacerCell: CollectionViewCell {
	private var heightConstraint: NSLayoutConstraint?

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .clear

		let heightConstraint = heightAnchor.constraint(equalToConstant: 0)
		self.heightConstraint = heightConstraint
		NSLayoutConstraint.activate([heightConstraint])
	}

	override func fill(from item: CollectionViewItem, mode: FillMode) {
		guard let castedItem = item as? PlainSpacerItem else {
			fatalError("Item must be PlainSpacerItem")
		}

		heightConstraint?.constant = castedItem.height
	}
}
