//
//  AnKitPlayground.swift
//  AnKitPlayground
//
//  Created by Anvipo on 23.10.2021.
//

import AnKit
import UIKit

enum AnKitPlayground {}

extension AnKitPlayground {
	static func makePlainLabelSupplementaryItem(
		text: String,
		elementKind: String
	) throws -> CollectionViewSupplementaryItem {
		try PlainLabelSupplementaryItem(
			text: text,
			textColor: Color.label.uiColor,
			textFont: Font.title1.uiFont,
			tintColor: Color.brand.uiColor,
			elementKind: elementKind,
			textInsets: .default(top: 14, bottom: 10),
			blurEffectStyle: .systemUltraThinMaterial,
			pinToVisibleBounds: true
		)
	}

	static func makePlainLabelItem(
		text: String,
		dividerColor: UIColor = DividerModel.defaultColor
	) throws -> CollectionViewItem {
		try PlainLabelItem(
			text: text,
			textColor: Color.label.uiColor,
			textFont: Font.body.uiFont,
			tintColor: Color.brand.uiColor,
			textAlignment: .center,
			textInsets: NSDirectionalEdgeInsets(
				horizontalInset: .defaultHorizontalOffset,
				verticalInset: 8
			),
			dividerModel: .lineDefaultOffsetFromStart(color: dividerColor)
		)
	}
}
