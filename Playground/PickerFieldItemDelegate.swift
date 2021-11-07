//
//  PickerFieldItemDelegate.swift
//  AnKitPlayground
//
//  Created by Anvipo on 08.11.2021.
//

protocol PickerFieldItemDelegate: FieldItemDelegate {
	func pickerFieldItem(
		_ item: PickerFieldItem,
		shouldChangeValueToComponent component: PickerFieldItem.SelectedComponentInfo
	) -> Bool

	func pickerFieldItemDidChangeComponent(
		_ item: PickerFieldItem,
		component: PickerFieldItem.SelectedComponentInfo
	)
}

extension PickerFieldItemDelegate {
	func pickerFieldItem(
		_ item: PickerFieldItem,
		shouldChangeValueToComponent component: PickerFieldItem.SelectedComponentInfo
	) -> Bool { true }

	func pickerFieldItemDidChangeComponent(
		_ item: PickerFieldItem,
		component: PickerFieldItem.SelectedComponentInfo
	) {}
}
