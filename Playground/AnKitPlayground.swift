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
	static func makePlainLabelBoundarySupplementaryItem(
		text: String,
		elementKind: String
	) throws -> CollectionViewBoundarySupplementaryItem {
		try PlainLabelBoundarySupplementaryItem(
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
		textColor: UIColor = Color.label.uiColor,
		textFont: UIFont = Font.body.uiFont,
		dividerColor: UIColor = DividerModel.defaultColor
	) throws -> CollectionViewItem {
		try PlainLabelItem(
			text: text,
			textColor: textColor,
			textFont: textFont,
			tintColor: Color.brand.uiColor,
			textAlignment: .center,
			textInsets: .default,
			dividerModel: .lineDefaultOffsetFromStart(color: dividerColor)
		)
	}
}

extension Button {
	func setup(
		text: String,
		onTap: @escaping () -> Void
	) {
		setup(
			text: text,
			textColor: Color.labelOnBrand.uiColor,
			textFont: Font.callout.uiFont,
			tintColor: Color.brand.uiColor,
			backgroundColor: Color.brand.uiColor,
			contentEdgeInsets: .default(verticalInset: 16),
			onTap: onTap
		)
	}
}
