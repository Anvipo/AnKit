//
//  UIEdgeInsets+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 07.11.2021.
//

import UIKit

public extension UIEdgeInsets {
	/// Creates instance with default horizontal and vertical offsetes.
	static var `default`: Self {
		Self(
			top: .defaultVerticalOffset,
			left: .defaultHorizontalOffset,
			bottom: .defaultVerticalOffset,
			right: .defaultHorizontalOffset
		)
	}

	/// Creates instance with specified `verticalInset` value and default leading and trailing values.
	/// - Parameter verticalInset: The inset on the top and bottom of an object.
	static func `default`(verticalInset: CGFloat = .zero) -> Self {
		Self(
			top: verticalInset,
			left: .defaultHorizontalOffset,
			bottom: verticalInset,
			right: .defaultHorizontalOffset
		)
	}
}
