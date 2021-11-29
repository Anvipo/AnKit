//
//  FieldCell.swift
//  AnKitPlayground
//
//  Created by Anvipo on 07.11.2021.
//

import AnKit
import UIKit

class FieldCell: CollectionViewCell {
	private let textFieldToolbar: UIToolbar
	private let titleLabel: UILabel
	private let textField: UITextField
	private let stackView: UIStackView
	private let dividerView: DividerView
	private var currentStackViewConstraints: [NSLayoutConstraint]
	private var currentStackViewInsets: NSDirectionalEdgeInsets
	private weak var item: FieldItem?

	override init(frame: CGRect) {
		textFieldToolbar = UIToolbar()
		titleLabel = UILabel()
		textField = UITextField()
		stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
		dividerView = DividerView(model: nil)
		currentStackViewConstraints = []
		currentStackViewInsets = .zero

		super.init(frame: frame)

		setupUI()
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		currentStackViewConstraints = []
		currentStackViewInsets = .zero
	}

	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		if self.point(inside: point, with: event) {
			return textField
		} else {
			return super.hitTest(point, with: event)
		}
	}

	override func fill(from item: CollectionViewItem, mode: FillMode) {
		super.fill(from: item, mode: mode)

		guard let castedItem = item as? FieldItem else {
			assertionFailure("?")
			return
		}
		self.item = castedItem

		contentView.backgroundColor = castedItem.backgroundColor
		contentView.tintColor = castedItem.tintColor

		textFieldToolbar.tintColor = castedItem.tintColor
		textFieldToolbar.items = castedItem.toolbarItems
		if textFieldToolbar.items != nil {
			textFieldToolbar.sizeToFit()
		}

		titleLabel.numberOfLines = castedItem.titleNumberOfLines
		titleLabel.font = castedItem.titleFont
		titleLabel.textColor = castedItem.titleColor
		titleLabel.tintColor = castedItem.tintColor

		textField.font = castedItem.textFont
		textField.borderStyle = castedItem.textFieldBorderStyle
		textField.textColor = castedItem.textColor
		textField.tintColor = castedItem.tintColor

		dividerView.tintColor = castedItem.tintColor
		dividerView.isHidden = castedItem.dividerModel == nil
		dividerView.model = castedItem.dividerModel

		castedItem.currentResponderProvider = self

		setupStyle()
		setContent(from: castedItem)

		let newStackViewInsets = castedItem.contentInsets

		if currentStackViewConstraints.isEmpty || newStackViewInsets != currentStackViewInsets {
			currentStackViewInsets = newStackViewInsets
			NSLayoutConstraint.deactivate(currentStackViewConstraints)
			currentStackViewConstraints = stackView.makeConstraints(to: contentView, insets: newStackViewInsets)
			NSLayoutConstraint.activate(currentStackViewConstraints)
		}
	}

	func setContent(from item: FieldItem) {
		assertionFailure("Реализуй в наследнике")
	}

	func textFieldDidChange(text: String) {
		assertionFailure("Реализуй в наследнике")
	}
}

extension FieldCell {
	func set(title: String) {
		titleLabel.text = title
	}

	func set(text: String) {
		textField.text = text
	}

	func set(keyboardType: UIKeyboardType) {
		textField.keyboardType = keyboardType
	}

	func set(inputView: UIView) {
		textField.inputView = inputView
	}

	func setupStyle() {
		guard let item = item else {
			assertionFailure("?")
			return
		}

		if textField.isFirstResponder {
			titleLabel.textColor = Color.brand.uiColor
			dividerView.model = item.dividerModel?.copy(color: Color.brand.uiColor)
		} else {
			titleLabel.textColor = item.titleColor
			dividerView.model = item.dividerModel
		}
	}
}

extension FieldCell: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		setupStyle()
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		setupStyle()
	}
}

extension FieldCell: CurrentResponderProviderProtocol {
	var currentResponder: UIResponder? {
		textField
	}
}

private extension FieldCell {
	@objc
	func textFieldDidChange(_ textField: UITextField) {
		textFieldDidChange(text: textField.text ?? "")
	}

	func setupUI() {
		textField.delegate = self
		textField.inputAccessoryView = textFieldToolbar
		textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

		stackView.axis = .vertical
		stackView.spacing = 4

		dividerView.setContentHuggingPriority(.required, for: .vertical)
		dividerView.setContentHuggingPriority(.required, for: .horizontal)

		contentView.addSubviewsForConstraintsUse([stackView, dividerView])

		NSLayoutConstraint.activate([
			dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
