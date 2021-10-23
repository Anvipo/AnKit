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
	public var text: String {
		didSet {
			typeErasedContent = text
		}
	}

	let textColor: UIColor
	let textFont: UIFont
	let tintColor: UIColor

	let textAlignment: NSTextAlignment
	let textNumberOfLines: Int
	let textInsets: NSDirectionalEdgeInsets
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
	public init(
		text: String,
		textColor: UIColor,
		textFont: UIFont,
		tintColor: UIColor,
		textAlignment: NSTextAlignment = .natural,
		textNumberOfLines: Int = 1,
		textInsets: NSDirectionalEdgeInsets = .zero,
		backgroundColor: UIColor = .clear,
		dividerModel: DividerModel? = nil
	) throws {
		self.text = text
		self.textColor = textColor
		self.textFont = textFont
		self.tintColor = tintColor

		self.textAlignment = textAlignment
		self.textNumberOfLines = textNumberOfLines
		self.textInsets = textInsets
		self.backgroundColor = backgroundColor
		self.dividerModel = dividerModel

		isShimmering = false

		try super.init(typeErasedContent: text)
	}
}

extension PlainLabelItem: Dividerable {}

extension PlainLabelItem: Shimmerable {}
