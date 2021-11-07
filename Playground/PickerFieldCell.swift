//
//  PickerFieldCell.swift
//  AnKit
//
//  Created by Anvipo on 08.11.2021.
//

import AnKit
import UIKit

final class PickerFieldCell: FieldCell {
	private let pickerView: UIPickerView
	private var lastChosenComponent: PickerFieldItem.SelectedComponentInfo?
	private weak var item: PickerFieldItem?

	override init(frame: CGRect) {
		pickerView = UIPickerView()

		super.init(frame: frame)

		setupUI()
	}

	override func setContent(from item: FieldItem) {
		guard let castedItem = item as? PickerFieldItem else {
			assertionFailure("?")
			return
		}
		self.item = castedItem

		pickerView.tintColor = castedItem.tintColor
		lastChosenComponent = castedItem.selectedComponent

		set(title: castedItem.title)
		set(text: castedItem.text(for: castedItem.selectedComponent))
	}
}

extension PickerFieldCell: UIPickerViewDelegate {
	func pickerView(
		_ pickerView: UIPickerView,
		titleForRow row: Int,
		forComponent component: Int
	) -> String? {
		guard let item = item else {
			assertionFailure("?")
			return nil
		}

		let component = PickerFieldItem.SelectedComponentInfo(
			componentIndex: component,
			componentRowIndex: row
		)

		return item.text(for: component)
	}

	func pickerView(
		_ pickerView: UIPickerView,
		didSelectRow row: Int,
		inComponent component: Int
	) {
		guard let item = item else {
			assertionFailure("?")
			return
		}

		let newComponent = PickerFieldItem.SelectedComponentInfo(
			componentIndex: component,
			componentRowIndex: row
		)

		let shouldChange = item.delegate?.pickerFieldItem(
			item,
			shouldChangeValueToComponent: newComponent
		) ?? true

		if shouldChange {
			lastChosenComponent = newComponent
			item.selectedComponent = newComponent

			set(text: item.text(for: item.selectedComponent))

			item.delegate?.pickerFieldItemDidChangeComponent(item, component: newComponent)
		} else if let lastChosenComponent = lastChosenComponent {
			pickerView.selectRow(
				lastChosenComponent.componentRowIndex,
				inComponent: lastChosenComponent.componentIndex,
				animated: UIView.areAnimationsEnabled
			)
		} else {
			assertionFailure("?")
		}
	}
}

extension PickerFieldCell: UIPickerViewDataSource {
	func numberOfComponents(
		in pickerView: UIPickerView
	) -> Int {
		guard let item = item else {
			assertionFailure("?")
			return 0
		}

		return item.numberOfComponents
	}

	func pickerView(
		_ pickerView: UIPickerView,
		numberOfRowsInComponent component: Int
	) -> Int {
		guard let item = item else {
			assertionFailure("?")
			return 0
		}

		return item.numberOfRows(in: component)
	}
}

private extension PickerFieldCell {
	func setupUI() {
		pickerView.delegate = self
		pickerView.dataSource = self
		set(inputView: pickerView)
	}
}
