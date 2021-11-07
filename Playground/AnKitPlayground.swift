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
		elementKind: String,
		blurEffectStyle: UIBlurEffect.Style? = .systemUltraThinMaterial,
		pinToVisibleBounds: Bool = true,
		contentInsets: NSDirectionalEdgeInsets = .zero
	) throws -> CollectionViewBoundarySupplementaryItem {
		try PlainLabelBoundarySupplementaryItem(
			text: text,
			textColor: Color.label.uiColor,
			textFont: Font.title1.uiFont,
			tintColor: Color.brand.uiColor,
			elementKind: elementKind,
			textInsets: .default(top: 14, bottom: 10),
			blurEffectStyle: blurEffectStyle,
			pinToVisibleBounds: pinToVisibleBounds,
			contentInsets: contentInsets
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

	static func makeTransitionTypePickerFieldItem(
		id: CollectionViewItem.ID,
		title: String,
		selectedComponent: PickerFieldItem.SelectedComponentInfo,
		delegate: PickerFieldItemDelegate
	) throws -> TransitionTypePickerFieldItem {
		try TransitionTypePickerFieldItem(
			id: id,
			title: title,
			data: [CATransitionType.allCases],
			selectedComponent: selectedComponent,
			titleColor: Self.defaultTitleColor.uiColor,
			titleFont: Self.defaultTitleFont.uiFont,
			textColor: Self.defaultTextColor.uiColor,
			textFont: Self.defaultFieldItemFont.uiFont,
			tintColor: Self.defaultTintColor.uiColor,
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

extension String {
	static var mock: Self {
"""
Lorem ipsum dolor sit amet, \
consectetur adipiscing elit, \
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \
Ut enim ad minim veniam, \
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. \
Excepteur sint occaecat cupidatat non proident, \
sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
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
