//
//  ColoredTVI.swift
//  AnKitPlayground
//
//  Created by Anvipo on 29.11.2021.
//

import AnKit
import UIKit

final class ColoredTVI: TableViewItem {
	let color: UIColor

	override var cellType: TableViewCell.Type {
		ColoredTVC.self
	}

	init(
		color: UIColor,
		id: ID = ID()
	) throws {
		self.color = color

		try super.init(id: id)
	}
}
