//
//  PickerFieldItem.SelectedComponentInfo.swift
//  AnKitPlayground
//
//  Created by Anvipo on 08.11.2021.
//

extension PickerFieldItem {
	struct SelectedComponentInfo {
		let componentIndex: Int
		let componentRowIndex: Int
	}
}

extension PickerFieldItem.SelectedComponentInfo: Equatable {}

extension PickerFieldItem.SelectedComponentInfo: Hashable {}
