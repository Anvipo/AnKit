//
//  FieldItem.swift
//  AnKit
//
//  Created by Anvipo on 07.11.2021.
//
// swiftlint:disable discouraged_optional_collection

import AnKit
import UIKit

class FieldItem: CollectionViewItem {
	let titleColor: UIColor
	let titleFont: UIFont
	let textColor: UIColor
	let textFont: UIFont
	let tintColor: UIColor

	let titleNumberOfLines: Int
	let textFieldBorderStyle: UITextField.BorderStyle
	let contentInsets: NSDirectionalEdgeInsets
	let backgroundColor: UIColor

	var toolbarItems: [UIBarButtonItem]?
	var currentResponderProvider: CurrentResponderProviderProtocol?
	weak var fieldItemDelegate: FieldItemDelegate?

	var dividerModel: DividerModel?

	override var cellType: CollectionViewCell.Type {
		FieldCell.self
	}

	init(
		id: CollectionViewItem.ID,
		titleColor: UIColor,
		titleFont: UIFont,
		textColor: UIColor,
		textFont: UIFont,
		tintColor: UIColor,
		delegate: FieldItemDelegate,
		toolbarItems: [UIBarButtonItem]? = nil,
		titleNumberOfLines: Int = 1,
		textFieldBorderStyle: UITextField.BorderStyle = .none,
		dividerModel: DividerModel? = nil,
		backgroundColor: UIColor = .clear,
		contentInsets: NSDirectionalEdgeInsets = .zero
	) throws {
		self.titleColor = titleColor
		self.titleFont = titleFont
		self.textColor = textColor
		self.textFont = textFont
		self.tintColor = tintColor
		self.fieldItemDelegate = delegate

		self.toolbarItems = toolbarItems
		self.titleNumberOfLines = titleNumberOfLines
		self.textFieldBorderStyle = textFieldBorderStyle
		self.dividerModel = dividerModel
		self.backgroundColor = backgroundColor
		self.contentInsets = contentInsets

		try super.init(id: id)
	}

	override func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)

		hasher.combine(titleColor)
		hasher.combine(titleFont)
		hasher.combine(textColor)
		hasher.combine(textFont)
		hasher.combine(tintColor)

		hasher.combine(toolbarItems)
		hasher.combine(titleNumberOfLines)
		hasher.combine(textFieldBorderStyle)
		hasher.combine(dividerModel)
		hasher.combine(backgroundColor)
		hasher.combine(contentInsets)
	}
}

extension FieldItem: Dividerable {}

extension FieldItem {
	static func == (
		lhs: FieldItem,
		rhs: FieldItem
	) -> Bool {
		(lhs as CollectionViewItem) == (rhs as CollectionViewItem) &&

		lhs.titleColor == rhs.titleColor &&
		lhs.titleFont == rhs.titleFont &&
		lhs.textColor == rhs.textColor &&
		lhs.textFont == rhs.textFont &&
		lhs.tintColor == rhs.tintColor &&

		lhs.toolbarItems == rhs.toolbarItems &&
		lhs.titleNumberOfLines == rhs.titleNumberOfLines &&
		lhs.textFieldBorderStyle == rhs.textFieldBorderStyle &&
		lhs.dividerModel == rhs.dividerModel &&
		lhs.backgroundColor == rhs.backgroundColor &&
		lhs.contentInsets == rhs.contentInsets
	}
}
