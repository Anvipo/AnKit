//
//  PlainLabelItem.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// Item for plain label cell in section.
public final class PlainLabelItem: CollectionViewItem {
	/// The text that the label displays.
	public var text: String

	let textColor: UIColor
	let textFont: UIFont
	let textAlignment: NSTextAlignment
	let textNumberOfLines: Int
	let textInsets: NSDirectionalEdgeInsets

	let tintColor: UIColor
	let backgroundColor: UIColor

	public var dividerModel: DividerModel?

	public var isShimmering: Bool

	override public var cellType: CollectionViewCell.Type {
		PlainLabelCell.self
	}

	/// Initialize item with specified parameters.
	/// - Parameters:
	///   - text: The text that the label displays.
	///   - textColor: The color of the text.
	///   - textFont: The font of the text.
	///   - tintColor: The first nondefault tint color value in the view’s hierarchy,
	///   ascending from and starting with the view itself.
	///   - textAlignment: The technique for aligning the text.
	///   - textNumberOfLines: The maximum number of lines for rendering text.
	///   - textInsets: The inset distances for text.
	///   - backgroundColor: The view’s background color.
	///   - dividerModel: Divider model.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		text: String,
		textColor: UIColor,
		textFont: UIFont,
		tintColor: UIColor,
		textAlignment: NSTextAlignment = .natural,
		textNumberOfLines: Int = 1,
		textInsets: NSDirectionalEdgeInsets = .zero,
		backgroundColor: UIColor = .clear,
		dividerModel: DividerModel? = nil,
		isShimmering: Bool = false,
		id: ID = ID()
	) throws {
		self.text = text
		self.textColor = textColor
		self.textFont = textFont
		self.textAlignment = textAlignment
		self.textNumberOfLines = textNumberOfLines
		self.textInsets = textInsets

		self.tintColor = tintColor
		self.backgroundColor = backgroundColor
		self.dividerModel = dividerModel
		self.isShimmering = isShimmering

		try super.init(id: id)
	}

	override public func hash(into hasher: inout Hasher) {
		super.hash(into: &hasher)

		hasher.combine(text)
		hasher.combine(textColor)
		hasher.combine(textFont)
		hasher.combine(textAlignment)
		hasher.combine(textNumberOfLines)
		hasher.combine(textInsets)

		hasher.combine(tintColor)
		hasher.combine(backgroundColor)
		hasher.combine(dividerModel)
		hasher.combine(isShimmering)
	}
}

extension PlainLabelItem: Dividerable {}

extension PlainLabelItem: Shimmerable {}

public extension PlainLabelItem {
	// swiftlint:disable:next missing_docs
	static func == (
		lhs: PlainLabelItem,
		rhs: PlainLabelItem
	) -> Bool {
		(lhs as CollectionViewItem) == (rhs as CollectionViewItem) &&

		lhs.text == rhs.text &&
		lhs.textColor == rhs.textColor &&
		lhs.textFont == rhs.textFont &&
		lhs.textAlignment == rhs.textAlignment &&
		lhs.textNumberOfLines == rhs.textNumberOfLines &&
		lhs.textInsets == rhs.textInsets &&

		lhs.tintColor == rhs.tintColor &&
		lhs.backgroundColor == rhs.backgroundColor &&
		lhs.dividerModel == rhs.dividerModel &&
		lhs.isShimmering == rhs.isShimmering
	}
}
