//
//  PlainLabelSupplementaryItem.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

/// Item for plain header in section.
public final class PlainLabelSupplementaryItem: CollectionViewSupplementaryItem {
	let text: String
	let textColor: UIColor
	let textFont: UIFont
	let textAlignment: NSTextAlignment
	let textNumberOfLines: Int
	let textInsets: NSDirectionalEdgeInsets

	let blurEffectStyle: UIBlurEffect.Style?
	let tintColor: UIColor
	let backgroundColor: UIColor

	public var isShimmering: Bool

	override public var supplementaryViewType: CollectionViewSupplementaryView.Type {
		PlainLabelSupplementaryView.self
	}

	/// Initialize item with specified parameters.
	/// - Parameters:
	///   - text: The text that the label displays.
	///   - textColor: The color of the text.
	///   - textFont: The font of the text.
	///   - tintColor: The first nondefault tint color value in the view’s hierarchy,
	///   ascending from and starting with the view itself.
	///   - elementKind: A string that identifies the type of supplementary item.
	///   - textAlignment: The technique for aligning the text.
	///   - textNumberOfLines: The maximum number of lines for rendering text.
	///   - textInsets: The inset distances for text.
	///   - backgroundColor: The view’s background color.
	///   - blurEffectStyle: The intensity of the blur effect.
	///   - pinToVisibleBounds: A Boolean value that indicates whether a header is pinned
	///   to the top or bottom visible boundary of the section or layout it's attached to.
	///   - isShimmering: Is subject shimmering.
	///   - contentInsets: The amount of space between the content of the item and its boundaries.
	///   - id: The stable identity of the entity associated with this instance.
	public init(
		text: String,
		textColor: UIColor,
		textFont: UIFont,
		tintColor: UIColor,
		elementKind: String,
		textAlignment: NSTextAlignment = .natural,
		textNumberOfLines: Int = 1,
		textInsets: NSDirectionalEdgeInsets = .zero,
		backgroundColor: UIColor = .clear,
		blurEffectStyle: UIBlurEffect.Style? = nil,
		pinToVisibleBounds: Bool = false,
		isShimmering: Bool = false,
		contentInsets: NSDirectionalEdgeInsets = .zero,
		id: ID = ID()
	) throws {
		self.text = text
		self.textColor = textColor
		self.textFont = textFont
		self.textAlignment = textAlignment
		self.textNumberOfLines = textNumberOfLines
		self.textInsets = textInsets

		self.blurEffectStyle = blurEffectStyle
		self.tintColor = tintColor
		self.backgroundColor = backgroundColor
		self.isShimmering = isShimmering

		super.init(
			elementKind: elementKind,
			contentInsets: contentInsets,
			pinToVisibleBounds: pinToVisibleBounds,
			id: id
		)
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
		hasher.combine(blurEffectStyle)
		hasher.combine(backgroundColor)
		hasher.combine(isShimmering)
	}
}

extension PlainLabelSupplementaryItem: Shimmerable {}

public extension PlainLabelSupplementaryItem {
	// swiftlint:disable:next missing_docs
	static func == (
		lhs: PlainLabelSupplementaryItem,
		rhs: PlainLabelSupplementaryItem
	) -> Bool {
		(lhs as CollectionViewSupplementaryItem) == (rhs as CollectionViewSupplementaryItem) &&

		lhs.text == rhs.text &&
		lhs.textColor == rhs.textColor &&
		lhs.textFont == rhs.textFont &&
		lhs.textAlignment == rhs.textAlignment &&
		lhs.textNumberOfLines == rhs.textNumberOfLines &&
		lhs.textInsets == rhs.textInsets &&

		lhs.tintColor == rhs.tintColor &&
		lhs.blurEffectStyle == rhs.blurEffectStyle &&
		lhs.backgroundColor == rhs.backgroundColor &&
		lhs.isShimmering == rhs.isShimmering
	}
}
