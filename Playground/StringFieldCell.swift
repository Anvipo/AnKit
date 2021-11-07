//
//  StringFieldCell.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import AnKit
import UIKit

final class StringFieldCell: FieldCell {
	private weak var item: StringFieldItem?

	override func setContent(from item: FieldItem) {
		guard let castedItem = item as? StringFieldItem else {
			assertionFailure("?")
			return
		}
		self.item = castedItem

		set(title: castedItem.title)
		set(text: castedItem.text)
		set(keyboardType: castedItem.textKeyboardType)
	}

	override func textFieldDidChange(text: String) {
		guard let item = item else {
			return
		}

		item.text = text

		guard let delegate = item.delegate else {
			return
		}

		let formattedText = delegate.stringFieldItemFormattedString(item)
		set(text: formattedText)
		item.text = formattedText
		delegate.stringFieldItemDidChangeString(item)
	}
}

extension StringFieldCell {
	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		guard let item = item,
			  let delegate = item.delegate
		else {
			assertionFailure("?")
			return true
		}

		let sourceText = textField.text ?? ""
		guard let stringRange = Range(range, in: sourceText) else {
			assertionFailure("?")
			return false
		}

		return delegate.stringFieldItem(
			item,
			shouldChangeCharactersIn: stringRange,
			replacementString: string
		)
	}
}
