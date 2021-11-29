//
//  PickerFieldItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 08.11.2021.
//
// swiftlint:disable unavailable_function discouraged_optional_collection

import AnKit
import UIKit

class PickerFieldItem: FieldItem {
	override final var cellType: CollectionViewCell.Type {
		PickerFieldCell.self
	}

	var selectedComponent: SelectedComponentInfo

	weak var delegate: PickerFieldItemDelegate?

	var title: String {
		fatalError("Implement this method")
	}

	var numberOfComponents: Int {
		fatalError("Implement this method")
	}

	init(
		id: CollectionViewItem.ID,
		selectedComponent: SelectedComponentInfo,
		titleColor: UIColor,
		titleFont: UIFont,
		textColor: UIColor,
		textFont: UIFont,
		tintColor: UIColor,
		delegate: PickerFieldItemDelegate,
		toolbarItems: [UIBarButtonItem]? = nil,
		titleNumberOfLines: Int = 1,
		textFieldBorderStyle: UITextField.BorderStyle = .none,
		dividerModel: DividerModel? = nil,
		backgroundColor: UIColor = .clear,
		contentInsets: NSDirectionalEdgeInsets = .zero
	) throws {
		self.selectedComponent = selectedComponent
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

	func numberOfRows(in component: Int) -> Int {
		fatalError("Implement this method")
	}

	func text(for selectedComponent: SelectedComponentInfo) -> String {
		fatalError("Implement this method")
	}

	override func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)

		hasher.combine(selectedComponent)
	}
}

extension PickerFieldItem {
	static func == (
		lhs: PickerFieldItem,
		rhs: PickerFieldItem
	) -> Bool {
		(lhs as FieldItem) == (rhs as FieldItem) &&

		lhs.selectedComponent == rhs.selectedComponent
	}
}
