//
//  UILabel+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

extension UILabel {
	func actualNumberOfLines(
		width: CGFloat,
		maximumNumberOfLines: Int = .zero,
		lineFragmentPadding: CGFloat = .zero
	) -> Int {
		let textStorage = NSTextStorage(
			string: text ?? "",
			attributes: [.font: font as Any]
		)

		let targetSize = CGSize(
			width: width,
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
