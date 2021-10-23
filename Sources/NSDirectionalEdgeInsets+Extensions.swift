//
//  NSDirectionalEdgeInsets+Extensions.swift
//  AnKit
//
//  Created by Anvipo on 29.08.2021.
//

import UIKit

public extension NSDirectionalEdgeInsets {
	/// Initializes with specified insets.
	/// - Parameters:
	///   - horizontalInset: Amount for horizontal insets.
	///   - verticalInset: Amount for vertical insets.
	init(
		horizontalInset: CGFloat,
		verticalInset: CGFloat = .zero
	) {
		self.init(
			top: verticalInset,
			leading: horizontalInset,
			bottom: verticalInset,
			trailing: horizontalInset
		)
	}

	/// Creates instance, which describing square insets.
	/// - Parameter side: Amount for side.
	static func square(side: CGFloat) -> Self {
		Self(
			top: side,
			leading: side,
			bottom: side,
			trailing: side
		)
	}

	/// Creates instance with specified `top` and `bottom` and default leading and trailing values.
	/// - Parameters:
	///   - top: The top edge inset value.
	///   - bottom: The trailing edge inset value.
	static func `default`(
		top: CGFloat = .zero,
		bottom: CGFloat = .zero
	) -> Self {
		Self(
			top: top,
			leading: .defaultHorizontalOffset,
			bottom: bottom,
			trailing: .defaultHorizontalOffset
		)
	}

	/// Return copy with specified parameters or copied values.
	/// - Parameters:
	///   - top: The top edge inset value. If you pass `nil`, then current value will be used.
	///   - leading: The leading edge inset value. If you pass `nil`, then current value will be used.
	///   - bottom: The bottom edge inset value. If you pass `nil`, then current value will be used.
	///   - trailing: The trailing edge inset value. If you pass `nil`, then current value will be used.
	func copy(
		top: CGFloat? = nil,
		leading: CGFloat? = nil,
		bottom: CGFloat? = nil,
		trailing: CGFloat? = nil
	) -> Self {
		Self(
			top: top ?? self.top,
			leading: leading ?? self.leading,
			bottom: bottom ?? self.bottom,
			trailing: trailing ?? self.trailing
		)
	}
}

extension NSDirectionalEdgeInsets: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(leading)
		hasher.combine(top)
		hasher.combine(trailing)
		hasher.combine(bottom)
	}
}
