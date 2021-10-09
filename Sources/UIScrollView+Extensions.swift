//
//  UIScrollView+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 30.08.2021.
//

import UIKit

public extension UIScrollView {
	/// Provides real Y content offset.
	var realContentOffsetY: CGFloat {
		contentOffset.y + contentInset.top + safeAreaInsets.top
	}

	/// Centers the content.
	func centerContent() {
		let frameHeight = frame.height
		let contentHeight = contentSize.height

		let centeringInset = (frameHeight - contentHeight) / 2
		let topInset = max(centeringInset, .zero)

		var newContentInset = contentInset
		newContentInset.top = topInset
		contentInset = newContentInset
	}
}
