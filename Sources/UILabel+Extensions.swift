//
//  UILabel+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

public extension UILabel {
	/// Calculates number of lines, which label's text will lay out.
	/// - Parameters:
	///   - availableWidth: Available width for label.
	///   - maximumNumberOfLines: The maximum number of lines that the text container can store.
	///   - lineFragmentPadding: The value for the text inset within line fragment rectangles.
	func actualNumberOfLines(
		availableWidth: CGFloat,
		maximumNumberOfLines: Int = .zero,
		lineFragmentPadding: CGFloat = .zero
	) -> Int {
		let textStorage = NSTextStorage(
			string: text ?? "",
			attributes: [.font: font as Any]
		)

		let targetSize = CGSize(
			width: availableWidth,
			height: UIView.layoutFittingCompressedSize.height
		)
		let textContainer = NSTextContainer(size: targetSize)
		textContainer.lineBreakMode = lineBreakMode
		textContainer.maximumNumberOfLines = maximumNumberOfLines
		textContainer.lineFragmentPadding = lineFragmentPadding

		let layoutManager = NSLayoutManager()
		layoutManager.textStorage = textStorage
		layoutManager.addTextContainer(textContainer)

		var numberOfLines = 0
		var index = 0
		var lineRange = NSRange(location: 0, length: 0)

		// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextLayout/Tasks/CountLines.html
		while index < layoutManager.numberOfGlyphs {
			layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
			index = NSMaxRange(lineRange)
			numberOfLines += 1
		}

		return numberOfLines
	}
}
