//
//  ColoredItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 15.11.2021.
//

import AnKit
import UIKit

final class ColoredItem: CollectionViewItem {
	let color: UIColor

	override var cellType: CollectionViewCell.Type {
		ColoredCell.self
	}

	init(
		color: UIColor,
		id: ID = ID()
	) throws {
		self.color = color

		try super.init(
			id: id
		)
	}
}
