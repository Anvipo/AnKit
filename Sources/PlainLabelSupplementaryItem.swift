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
	let tintColor: UIColor

	let textAlignment: NSTextAlignment
	let textNumberOfLines: Int
	let textInsets: NSDirectionalEdgeInsets
	let blurEffectStyle: UIBlurEffect.Style?
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
	///   - textAlignment: The technique for aligning the text.
	///   - textNumberOfLines: The maximum number of lines for rendering text.
	///   - textInsets: The inset distances for text.
	///   - backgroundColor: The view’s background color.
	///   - blurEffectStyle: The intensity of the blur effect.
	///   - pinToVisibleBounds: A Boolean value that indicates whether a header is pinned
	///   to the top or bottom visible boundary of the section or layout it's attached to.
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
		contentInsets: NSDirectionalEdgeInsets = .zero,
		id: ID = ID()
	) throws {
		self.text = text
		self.textColor = textColor
		self.textFont = textFont
		self.tintColor = tintColor

		self.textAlignment = textAlignment
		self.textNumberOfLines = textNumberOfLines
		self.textInsets = textInsets
		self.blurEffectStyle = blurEffectStyle
		self.backgroundColor = backgroundColor

		isShimmering = false

		super.init(
			typeErasedContent: text,
			elementKind: elementKind,
			contentInsets: contentInsets,
			pinToVisibleBounds: pinToVisibleBounds,
			id: id
		)
	}
}

extension PlainLabelSupplementaryItem: Shimmerable {}
