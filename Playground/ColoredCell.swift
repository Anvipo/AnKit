//
//  ColoredCell.swift
//  AnKitPlayground
//
//  Created by Anvipo on 15.11.2021.
//

import AnKit

final class ColoredCell: CollectionViewCell {
	override func fill(from item: CollectionViewItem, mode: FillMode) {
		guard let castedItem = item as? ColoredItem else {
			return
		}

		contentView.backgroundColor = castedItem.color
	}
}
