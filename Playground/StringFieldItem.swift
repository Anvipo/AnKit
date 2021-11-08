//
//  StringFieldItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//
// swiftlint:disable discouraged_optional_collection

import AnKit
import UIKit

final class StringFieldItem: FieldItem {
	let textKeyboardType: UIKeyboardType

	let title: String
	var text: String

	weak var delegate: StringFieldItemDelegate?

	override var cellType: CollectionViewCell.Type {
		StringFieldCell.self
	}

	init(
		id: CollectionViewItem.ID,
		title: String,
		text: String,
		titleColor: UIColor,
		titleFont: UIFont,
		textColor: UIColor,
		textFont: UIFont,
		tintColor: UIColor,
		textKeyboardType: UIKeyboardType,
		delegate: StringFieldItemDelegate,
		toolbarItems: [UIBarButtonItem]? = nil,
		titleNumberOfLines: Int = 1,
		textFieldBorderStyle: UITextField.BorderStyle = .none,
		dividerModel: DividerModel? = nil,
		backgroundColor: UIColor = .clear,
		contentInsets: NSDirectionalEdgeInsets = .zero
	) throws {
		self.textKeyboardType = textKeyboardType
		self.title = title
		self.text = text
		self.delegate = delegate

		try super.init(
			id: id,
			titleColor: titleColor,
			titleFont: titleFont,
			textColor: textColor,
			textFont: textFont,
			tintColor: tintColor,
			delegate: delegate,
			toolbarItems: toolbarItems,
			titleNumberOfLines: titleNumberOfLines,
			textFieldBorderStyle: textFieldBorderStyle,
			dividerModel: dividerModel,
			backgroundColor: backgroundColor,
			contentInsets: contentInsets
		)
	}

	override func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)

		hasher.combine(textKeyboardType)
		hasher.combine(title)
		hasher.combine(text)
	}
}

extension StringFieldItem {
	static func == (
		lhs: StringFieldItem,
		rhs: StringFieldItem
	) -> Bool {
		(lhs as FieldItem) == (rhs as FieldItem) &&

		lhs.textKeyboardType == rhs.textKeyboardType &&
		lhs.title == rhs.title &&
		lhs.text == rhs.text
	}
}
