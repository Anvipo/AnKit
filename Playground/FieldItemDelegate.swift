//
//  FieldItemDelegate.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

protocol FieldItemDelegate: AnyObject {
	func fieldItemDidBeginEditing(_ item: FieldItem)

	func fieldItemDidEndEditing(_ item: FieldItem)
}

extension FieldItemDelegate {
	func fieldItemDidBeginEditing(_ item: FieldItem) {}

	func fieldItemDidEndEditing(_ item: FieldItem) {}
}
