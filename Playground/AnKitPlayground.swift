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

	static func makeStringFieldItem(
		id: CollectionViewItem.ID,
		title: String,
		text: String,
		textKeyboardType: UIKeyboardType,
		delegate: StringFieldItemDelegate
	) throws -> StringFieldItem {
		try StringFieldItem(
			id: id,
			title: title,
			text: text,
			titleColor: Self.defaultTitleColor.uiColor,
			titleFont: Self.defaultTitleFont.uiFont,
			textColor: Self.defaultTextColor.uiColor,
			textFont: Self.defaultFieldItemFont.uiFont,
			tintColor: Self.defaultTintColor.uiColor,
			textKeyboardType: textKeyboardType,
			delegate: delegate,
			dividerModel: Self.defaultDividerModel,
			contentInsets: Self.defaultContentInsets
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

private extension AnKitPlayground {
	static var defaultTitleColor: Color {
		.secondaryLabel
	}

	static var defaultTitleFont: Font {
		.footnote
	}

	static var defaultTextColor: Color {
		.label
	}

	static var defaultTintColor: Color {
		.brand
	}

	static var defaultFieldItemFont: Font {
		.body
	}

	static var defaultDividerModel: DividerModel? {
		.lineFullWidth()
	}

	static var defaultContentInsets: NSDirectionalEdgeInsets {
		.init(
			top: 14,
			leading: .zero,
			bottom: 10,
			trailing: .zero
		)
	}
}
