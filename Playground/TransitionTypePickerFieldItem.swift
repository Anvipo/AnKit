//
//  TransitionTypePickerFieldItem.swift
//  AnKitPlayground
//
//  Created by Anvipo on 08.11.2021.
//
// swiftlint:disable discouraged_optional_collection

import AnKit
import UIKit

final class TransitionTypePickerFieldItem: PickerFieldItem {
	private let _title: String
	let data: [[CATransitionType]]

	override var title: String {
		_title
	}

	override var numberOfComponents: Int {
		data.count
	}

	init(
		id: CollectionViewItem.ID,
		title: String,
		data: [[CATransitionType]],
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
		contentInsets: NSDirectionalEdgeInsets = .zero,
		backgroundColor: UIColor = .clear
	) throws {
		self._title = title
		self.data = data

		try super.init(
			id: id,
			selectedComponent: selectedComponent,
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

	override func numberOfRows(in component: Int) -> Int {
		data[component].count
	}

	override func text(for selectedComponent: SelectedComponentInfo) -> String {
		data[selectedComponent.componentIndex][selectedComponent.componentRowIndex].rawValue
	}

	override func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)

		hasher.combine(title)
		hasher.combine(data)
	}
}

extension TransitionTypePickerFieldItem {
	static func == (
		lhs: TransitionTypePickerFieldItem,
		rhs: TransitionTypePickerFieldItem
	) -> Bool {
		(lhs as PickerFieldItem) == (rhs as PickerFieldItem) &&

		lhs.title == rhs.title &&
		lhs.data == rhs.data
	}
}
