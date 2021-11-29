//
//  ColoredTVC.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import AnKit

final class ColoredTVC: TableViewCell {
	override func fill(from item: TableViewItem, mode: FillMode) {
		super.fill(from: item, mode: mode)

		guard let castedItem = item as? ColoredTVI else {
			return
		}

		contentView.backgroundColor = castedItem.color
	}
}
