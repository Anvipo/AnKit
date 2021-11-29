//
//  StringFieldItemDelegate.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

protocol StringFieldItemDelegate: FieldItemDelegate {
	func stringFieldItem(
		_ item: StringFieldItem,
		shouldChangeCharactersIn range: Range<String.Index>,
		replacementString: String
	) -> Bool

	func stringFieldItemFormattedString(_ item: StringFieldItem) -> String

	func stringFieldItemDidChangeString(_ item: StringFieldItem)
}

extension StringFieldItemDelegate {
	func stringFieldItem(
		_ item: StringFieldItem,
		shouldChangeCharactersIn range: Range<String.Index>,
		replacementString: String
	) -> Bool { true }

	func stringFieldItemFormattedString(_ item: StringFieldItem) -> String {
		item.text
	}

	func stringFieldItemDidChangeString(_ item: StringFieldItem) {}
}
